import '../pcapng/blocks/enhanced_packet_block.dart';
import '../pcapng/pcapng_reader.dart';
import 'application/application_layer_frame.dart';
import 'data_link/data_link_layer_frame.dart';
import 'data_link/ethernet/ether_type.dart';
import 'data_link/ethernet/ethernet_frame.dart';
import 'data_link/ethernet/map_ethernet_frame.dart';
import 'network/ip4v/ipv4_frame.dart';
import 'network/ip4v/ipv4_protocol.dart';
import 'network/ip4v/map_ipv4_frame.dart';
import 'network/network_layer_frame.dart';
import 'packet.dart';
import 'transport/tcp/map_tcp_frame.dart';
import 'transport/tcp/tcp_frame.dart';
import 'transport/transport_layer_frame.dart';

extension EnhancedPacketBlockMappingExtension on EnhancedPacketBlock {
  Packet mapPacket() {
    final reader = ByteDataReader.fromBytes(payload);
    final mutablePacket = _MutablePacket(frameNumber: frameNumber)
      ..mapDataLinkLayer(reader)
      ..mapNetworkLayerFrame(reader)
      ..mapTransportLayerFrame(reader)
      ..mapApplicationLayerFrame(reader);

    return mutablePacket.toImmutable();
  }
}

class _MutablePacket {
  int frameNumber;
  DataLinkLayerFrame? dataLinkFrame;
  NetworkLayerFrame? networkLayerFrame;
  TransportLayerFrame? transportLayerFrame;
  ApplicationLayerFrame? applicationLayerFrame;

  _MutablePacket({
    required this.frameNumber,
    this.dataLinkFrame,
    this.networkLayerFrame,
    this.transportLayerFrame,
    this.applicationLayerFrame,
  });

  Packet toImmutable() => Packet(
        frameNumber: frameNumber,
        dataLinkFrame: dataLinkFrame,
        networkLayerFrame: networkLayerFrame,
        transportLayerFrame: transportLayerFrame,
        applicationLayerFrame: applicationLayerFrame,
      );
}

extension _MutablePacketMappingExtension on _MutablePacket {
  void mapDataLinkLayer(ByteDataReader reader) {
    dataLinkFrame = mapEthernetFrame(reader);
  }

  void mapNetworkLayerFrame(
    ByteDataReader reader,
  ) {
    if (this
        case _MutablePacket(dataLinkFrame: final EthernetFrame ethernetFrame)
        when ethernetFrame.etherType == EhterType.ipv4.value) {
      networkLayerFrame = mapIpv4Frame(reader);
    }
  }

  void mapTransportLayerFrame(
    ByteDataReader reader,
  ) {
    if (this case _MutablePacket(networkLayerFrame: final Ipv4Frame ipv4Frame)
        when ipv4Frame.protocol == Ip4vProtocol.tcp.value) {
      transportLayerFrame = mapTcpFrame(reader);
    }
  }

  void mapApplicationLayerFrame(
    ByteDataReader reader,
  ) {
    if (this
        case _MutablePacket(
          networkLayerFrame: final Ipv4Frame ipv4Frame,
          transportLayerFrame: final TcpFrame tcpFrame
        )) {
      final payloadLength = ipv4Frame.totalLength -
          ipv4Frame.headerLength -
          tcpFrame.headerLength;

      applicationLayerFrame =
          ApplicationLayerFrame(payload: reader.getBytes(payloadLength));
    }
  }
}
