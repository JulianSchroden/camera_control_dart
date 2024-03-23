import 'pcapng_block_types.dart';

abstract class PcapngBlockData {
  final int totalLength;

  const PcapngBlockData(this.totalLength);

  PcapngBlockType get type;
}
