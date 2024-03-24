// https://datatracker.ietf.org/doc/html/draft-ietf-opsawg-pcapng#name-section-header-block
// https://github.com/rshk/python-pcapng/blob/master/pcapng/scanner.py
// https://github.com/rshk/python-pcapng/blob/33e722f6d5cc41154fda56d8dff62e2970078fd5/pcapng/structs.py#L129

import 'dart:typed_data';

import 'package:camera_control_dart/src/common/extensions/list_extensions.dart';

import 'blocks/enhanced_packet_block.dart';
import 'blocks/section_header_block.dart';
import 'pcapng_block_data.dart';
import 'pcapng_block_types.dart';
import 'pcapng_reader.dart';

List<PcapngBlockData> parsePcapngBlocks(Uint8List fileData) {
  final reader = PcapngReader.fromBytes(fileData);
  final List<PcapngBlockData> parsedBlocks = [];

  int packetBlockCounter = 1;
  while (reader.hasUnreadBlock) {
    final blockReader = reader.readBlock();

    final rawType = blockReader.getUint32();
    final type = PcapngBlockType.values
        .firstWhereOrNull((type) => type.value == rawType);

    switch (type) {
      case PcapngBlockType.sectionHeader:
        {
          parsedBlocks.add(SectionHeaderBlock.fromBytes(blockReader));
        }
      case PcapngBlockType.enhancedPacketBlock:
        {
          parsedBlocks.add(
              EnhancedPacketBlock.fromBytes(packetBlockCounter, blockReader));
          packetBlockCounter++;
        }
      default:
        {
          final blockTotalLength = blockReader.getUint32();
          final bytestoSkip = blockTotalLength - 8;
          blockReader.skipBytes(bytestoSkip);
          print("type is $type and length is $blockTotalLength");
        }
    }
  }

  return parsedBlocks;
}
