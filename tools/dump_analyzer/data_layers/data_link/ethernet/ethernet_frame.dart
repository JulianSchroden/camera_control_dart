import 'dart:typed_data';

import '../data_link_layer_frame.dart';

class EthernetFrame extends DataLinkLayerFrame {
  final Uint8List destinationMac;
  final Uint8List sourceMac;
  final int etherType;

  EthernetFrame({
    required this.destinationMac,
    required this.sourceMac,
    required this.etherType,
  });
}
