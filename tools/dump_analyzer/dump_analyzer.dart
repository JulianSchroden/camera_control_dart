import 'dart:io';
import 'dart:typed_data';

import 'package:camera_control_dart/src/common/extensions/list_extensions.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/extensions/dump_bytes_extensions.dart';

import 'pcapng/blocks/enhanced_packet_block.dart';
import 'pcapng/blocks/section_header_block.dart';
import 'pcapng/pcapng_block_data.dart';
import 'pcapng/pcapng_block_types.dart';
import 'pcapng/pcapng_reader.dart';

// https://datatracker.ietf.org/doc/html/draft-ietf-opsawg-pcapng#name-section-header-block
// https://github.com/rshk/python-pcapng/blob/master/pcapng/scanner.py
// https://github.com/rshk/python-pcapng/blob/33e722f6d5cc41154fda56d8dff62e2970078fd5/pcapng/structs.py#L129

List<PcapngBlockData> parseBlocks(Uint8List fileData) {
  final reader = PcapngReader.fromBytes(fileData);
  final List<PcapngBlockData> parsedBlocks = [];

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
          parsedBlocks.add(EnhancedPacketBlock.fromBytes(blockReader));
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

void main() async {
  final file = File('test/_test_data/Connect_Set_Aputure_To_f5.pcapng');

  final fileData = await file.readAsBytes();
  final blocks = parseBlocks(fileData);

  final packetBlocks = blocks.whereType<EnhancedPacketBlock>().toList();

  print('######');
  final block39 = packetBlocks[39];
  print(block39.payload.dumpAsHex());
}


/*
i: 38

[
   00 00 00 00 32 14 06 00  36 fa 0d 42 8c 00 00 00
   8c 00 00 00 
   Ethernet:
               f8 a2 6d ae  50 68 bc d0 74 02 ac 8e
   08 00
   Internet Protocol:      
         45 02 00 7e 00 00  40 00 40 06 54 c6 c0 a8
   b2 2c c0 a8 b2 34 

   TCP:
                  f4 96  3d 7c 30 df b6 11 e9 cc
   a9 7e 80 18 08 0a c8 fe  00 00 01 01 08 0a 8e de
   2e 6b ff ff 90 4d

   PTP/IP:
                     4a 00  00 00 01 00 00 00 10 aa
   ab 67 bf 70 7c 43 8f 4f  32 b3 df d9 fd 1e 4d 00
   61 00 63 00 42 00 6f 00  6f 00 6b 00 20 00 50 00
   72 00 6f 00 20 00 76 00  6f 00 6e 00 20 00 4a 00
   75 00 6c 00 69 00 61 00  6e 00 00 00 00 00 01 00
]

]
*/