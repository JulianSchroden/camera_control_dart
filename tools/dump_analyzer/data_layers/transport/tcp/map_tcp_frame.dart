import '../../../pcapng/pcapng_reader.dart';
import 'tcp_frame.dart';

TcpFrame mapTcpFrame(ByteDataReader dataReader) {
  final sourcePort = dataReader.getUint16();
  final destinationPort = dataReader.getUint16();
  final sequenceNumber = dataReader.getUint32();
  final acknowledgementNumber = dataReader.getUint32();
  final headerLengthAndFlags = dataReader.getUint16();
  final headerLength = (headerLengthAndFlags >> 12) * 4;
  final flags = headerLengthAndFlags & 0x0FFF;
  final window = dataReader.getUint16();
  final checksum = dataReader.getUint16();
  final urgentPointer = dataReader.getUint16();
  dataReader.skipBytes(12); // skip options;

  return TcpFrame(
    sourcePort: sourcePort,
    destinationPort: destinationPort,
    headerLength: headerLength,
  );
}
