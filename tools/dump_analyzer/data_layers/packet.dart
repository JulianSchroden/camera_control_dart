import 'application/application_layer_frame.dart';
import 'data_link/data_link_layer_frame.dart';
import 'network/network_layer_frame.dart';
import 'transport/transport_layer_frame.dart';

class Packet {
  final int frameNumber;
  final DataLinkLayerFrame? dataLinkFrame;
  final NetworkLayerFrame? networkLayerFrame;
  final TransportLayerFrame? transportLayerFrame;
  final ApplicationLayerFrame? applicationLayerFrame;

  const Packet({
    required this.frameNumber,
    this.dataLinkFrame,
    this.networkLayerFrame,
    this.transportLayerFrame,
    this.applicationLayerFrame,
  });
}
