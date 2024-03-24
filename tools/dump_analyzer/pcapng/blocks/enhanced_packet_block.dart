import 'dart:typed_data';

import 'package:camera_control_dart/src/eos_ptp_ip/extensions/dump_bytes_extensions.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/extensions/int_as_hex_string_extension.dart';

import '../pcapng_block_data.dart';
import '../pcapng_block_types.dart';
import '../pcapng_reader.dart';

class EnhancedPacketBlock extends PcapngBlockData {
  final int frameNumber;
  final DateTime timeStamp;
  final Uint8List payload;

  EnhancedPacketBlock(
    this.frameNumber,
    super.totalLength,
    this.timeStamp,
    this.payload,
  );

  factory EnhancedPacketBlock.fromBytes(
      int frameNumber, PcapngReader blockReader) {
    final totalLength = blockReader.getUint32();
    final interfaceId = blockReader.getUint32();

    final timestampHigh = blockReader.getUint32();
    final timestampLow = blockReader.getUint32();
    final microsSinceEpoch = timestampHigh << 32 | timestampLow;
    final timeStamp = DateTime.fromMicrosecondsSinceEpoch(microsSinceEpoch);

    final capturedPacketLength = blockReader.getUint32();
    blockReader.getUint32(); // skip originalPacketLength
    final payload =
        Uint8List.fromList(blockReader.getBytes(capturedPacketLength));

    return EnhancedPacketBlock(frameNumber, totalLength, timeStamp, payload);
  }

  @override
  PcapngBlockType get type => PcapngBlockType.enhancedPacketBlock;
}
