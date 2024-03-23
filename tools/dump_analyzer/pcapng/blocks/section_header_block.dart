import 'package:camera_control_dart/src/eos_ptp_ip/extensions/int_as_hex_string_extension.dart';

import '../pcapng_block_data.dart';
import '../pcapng_block_types.dart';
import '../pcapng_reader.dart';

class SectionHeaderBlock extends PcapngBlockData {
  SectionHeaderBlock(super.totalLength);

  factory SectionHeaderBlock.fromBytes(PcapngReader blockReader) {
    final totalLength = blockReader.getUint32();
    final byteOrderMagic = blockReader.getUint32(); // 0x1A2B3C4D
    final mayorVersion = blockReader.getUint16();
    final minorVersion = blockReader.getUint16();
    final sectionLength = blockReader.getUint64();
    print(
        'type: SectionHeaderBlock, blockTotalLength: $totalLength, byteOrderMagic: ${byteOrderMagic.asHex()}, version: $mayorVersion.$minorVersion, sectionLength: $sectionLength');
    return SectionHeaderBlock(totalLength);
  }

  @override
  PcapngBlockType get type => PcapngBlockType.sectionHeader;
}
