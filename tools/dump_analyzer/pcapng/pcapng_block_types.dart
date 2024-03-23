enum PcapngBlockType {
  sectionHeader,
  interfaceDescription,
  packetBlock,
  simplePacketBlock,
  nameResolutionBlock,
  interfaceStatisticsBlock,
  enhancedPacketBlock,
}

extension PcapngBlockTypeValue on PcapngBlockType {
  int get value {
    switch (this) {
      case PcapngBlockType.sectionHeader:
        return 0x0A0D0D0A;
      case PcapngBlockType.interfaceDescription:
        return 0x00000001;
      case PcapngBlockType.packetBlock:
        return 0x00000002;
      case PcapngBlockType.simplePacketBlock:
        return 0x00000003;
      case PcapngBlockType.nameResolutionBlock:
        return 0x00000004;
      case PcapngBlockType.interfaceStatisticsBlock:
        return 0x00000005;
      case PcapngBlockType.enhancedPacketBlock:
        return 0x00000006;
    }
  }
}
