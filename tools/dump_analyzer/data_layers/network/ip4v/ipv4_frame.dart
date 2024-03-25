import '../network_layer_frame.dart';
import 'ipv4_address.dart';

class Ipv4Frame extends NetworkLayerFrame {
  final int version;
  final int headerLength;
  final int totalLength;
  final int protocol;
  final Ipv4Address destinationAddress;
  final Ipv4Address sourceAddress;

  Ipv4Frame({
    required this.version,
    required this.headerLength,
    required this.totalLength,
    required this.protocol,
    required this.sourceAddress,
    required this.destinationAddress,
  });
}
