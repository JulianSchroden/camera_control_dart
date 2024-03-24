import 'dart:typed_data';

import '../../pcapng/pcapng_reader.dart';
import 'ipv4_address.dart';
import 'ipv4_frame.dart';

Ipv4Frame mapIpv4Frame(Uint8List payload) {
  final dataReader = ByteDataReader.fromBytes(payload);
  final versionAndHeaderByte = dataReader.getUint8();
  final version = versionAndHeaderByte >> 4;
  final headerLength = (versionAndHeaderByte & 0xF) * 4;
  dataReader.getUint8(); // skip Differenciated Services Field
  final totalLength = dataReader.getUint16();
  dataReader.skipBytes(5);
  final protocol = dataReader.getUint8();
  dataReader.getUint16(); // skip header checksum status

  final sourceAddress = Ipv4Address(dataReader.getUint32());
  final destinationAddress = Ipv4Address(dataReader.getUint32());

  final content = dataReader.getRemainingBytes();

  return Ipv4Frame(
    version: version,
    headerLength: headerLength,
    totalLength: totalLength,
    protocol: protocol,
    sourceAddress: sourceAddress,
    destinationAddress: destinationAddress,
    payload: content,
  );
}
