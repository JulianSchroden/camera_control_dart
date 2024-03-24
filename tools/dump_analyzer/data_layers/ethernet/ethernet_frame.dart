import 'dart:typed_data';

class EthernetFrame {
  final int frameNumber;
  final Uint8List destinationMac;
  final Uint8List sourceMac;
  final int etherType;
  final Uint8List payload;

  EthernetFrame({
    required this.frameNumber,
    required this.destinationMac,
    required this.sourceMac,
    required this.etherType,
    required this.payload,
  });
}
