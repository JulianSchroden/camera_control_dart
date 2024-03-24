import 'dart:typed_data';

import 'ipv4_address.dart';

class Ipv4Frame {
  final int version;
  final int headerLength;
  final int totalLength;
  final int protocol;
  final Ipv4Address destinationAddress;
  final Ipv4Address sourceAddress;
  final Uint8List payload;

  Ipv4Frame({
    required this.version,
    required this.headerLength,
    required this.totalLength,
    required this.protocol,
    required this.sourceAddress,
    required this.destinationAddress,
    required this.payload,
  });
}
