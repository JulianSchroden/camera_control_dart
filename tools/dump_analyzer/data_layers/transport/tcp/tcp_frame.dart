import '../transport_layer_frame.dart';

class TcpFrame extends TransportLayerFrame {
  final int sourcePort;
  final int destinationPort;
  final int headerLength;

  TcpFrame({
    required this.sourcePort,
    required this.destinationPort,
    required this.headerLength,
  });

  @override
  String toString() {
    return 'TcpFrame(sourcePort: $sourcePort, destinationPort: $destinationPort, headerLength: $headerLength)';
  }
}
