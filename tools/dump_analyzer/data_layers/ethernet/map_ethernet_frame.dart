import 'dart:typed_data';

import '../../pcapng/blocks/enhanced_packet_block.dart';
import '../../pcapng/pcapng_reader.dart';
import 'ethernet_frame.dart';

EthernetFrame mapEthernetFrame(EnhancedPacketBlock packetBlock) {
  final dataReader = ByteDataReader.fromBytes(packetBlock.payload);
  final destinationMac = dataReader.getBytes(6);
  final sourceMac = dataReader.getBytes(6);
  final ehterType = dataReader.getUint16();
  final payload = Uint8List.fromList(dataReader.getRemainingBytes());

  return EthernetFrame(
      frameNumber: packetBlock.frameNumber,
      destinationMac: destinationMac,
      sourceMac: sourceMac,
      etherType: ehterType,
      payload: payload);
}
