import 'dart:io';

import 'package:camera_control_dart/src/eos_ptp_ip/extensions/dump_bytes_extensions.dart';

import 'data_layers/ethernet/ether_type.dart';
import 'data_layers/ethernet/ethernet_frame_mapping.dart';
import 'pcapng/blocks/enhanced_packet_block.dart';
import 'pcapng/parse_pcapng_blocks.dart';

void main() async {
  final file = File('test/_test_data/Connect_Set_Aputure_To_f5.pcapng');

  final fileData = await file.readAsBytes();
  final blocks = parsePcapngBlocks(fileData);

  final ethernetFrames = blocks
      .whereType<EnhancedPacketBlock>()
      .map((packetBlock) => mapEthernetFrame(packetBlock))
      .where((ethernetFrame) => ethernetFrame.etherType == EhterType.ipv4.value)
      .toList();

  print('######');
  final block39 =
      ethernetFrames.firstWhere((element) => element.frameNumber == 39);
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