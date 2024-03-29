import 'dart:typed_data';

import 'package:camera_control_dart/src/eos_ptp_ip/extensions/dump_bytes_extensions.dart';

class ApplicationLayerFrame {
  final Uint8List payload;

  const ApplicationLayerFrame({required this.payload});

  @override
  String toString() {
    return 'ApplicationLayerFrame(payload: \n${payload.dumpAsHex()}\n)';
  }
}
