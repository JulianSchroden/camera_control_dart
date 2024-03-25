import '../../../pcapng/blocks/enhanced_packet_block.dart';
import '../../../pcapng/pcapng_reader.dart';
import 'ethernet_frame.dart';

EthernetFrame mapEthernetFrame(ByteDataReader dataReader) {
  final destinationMac = dataReader.getBytes(6);
  final sourceMac = dataReader.getBytes(6);
  final ehterType = dataReader.getUint16();

  return EthernetFrame(
    destinationMac: destinationMac,
    sourceMac: sourceMac,
    etherType: ehterType,
  );
}
