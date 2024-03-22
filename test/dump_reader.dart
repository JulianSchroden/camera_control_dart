import 'dart:io';
import 'dart:typed_data';

import 'package:camera_control_dart/src/eos_ptp_ip/extensions/dump_bytes_extensions.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/extensions/int_as_hex_string_extension.dart';

// https://datatracker.ietf.org/doc/html/draft-ietf-opsawg-pcapng#name-section-header-block
// https://github.com/rshk/python-pcapng/blob/master/pcapng/scanner.py
// https://github.com/rshk/python-pcapng/blob/33e722f6d5cc41154fda56d8dff62e2970078fd5/pcapng/structs.py#L129

class ByteDataReader {
  int _offset = 0;
  final ByteData _data;

  ByteDataReader(this._data);

  factory ByteDataReader.fromBytes(Uint8List bytes) {
    return ByteDataReader(ByteData.view(bytes.buffer));
  }

  int getUint64() {
    final result = _data.getUint64(_offset, Endian.little);
    _offset += 8;
    return result;
  }

  int getUint32() {
    final result = _data.getUint32(_offset, Endian.little);
    _offset += 4;
    return result;
  }

  int getUint16() {
    final result = _data.getUint32(_offset, Endian.little);
    _offset += 2;
    return result;
  }

  Uint8List getBytes(int count) {
    final currentOffset = _data.offsetInBytes + _offset;
    _offset += count;

    return Uint8List.view(
      _data.buffer,
      currentOffset,
      count,
    );
  }

  int get length => _data.lengthInBytes;

  /// 111720

  void skipBytes(int bytesToSkip) {
    _offset += bytesToSkip;
  }
}

void main() async {
  final file = File('test/_test_data/Connect_Set_Aputure_To_f5.pcapng');

  final byteContent = await file.readAsBytes();

  final reader = ByteDataReader.fromBytes(byteContent);

  print("file length: ${reader.length}");

  const sectionHeaderType = 0x0A0D0D0A;
  const interfaceDescriptionType = 0x00000001;
  const nameResolutionBlockType = 0x00000004;
  const interfaceStatisticsBlockType = 0x00000005;
  const enhancedPacketBlockType = 0x00000006;

  int i = 1; // TODO: increment counter only for enhancedPacketBlockType
  while (true) {
    final type = reader.getUint32(); // 4

    switch (type) {
      case sectionHeaderType:
        {
          final blockTotalLength = reader.getUint32();
          final byteOrderMagic = reader.getUint32(); // 0x1A2B3C4D
          final mayorVersion = reader.getUint16();
          final minorVersion = reader.getUint16();
          final sectionLength = reader.getUint64();

          reader.skipBytes(blockTotalLength - 24);

          print(
              'type: ${type.asHex()}, blockTotalLength: $blockTotalLength, byteOrderMagic: ${byteOrderMagic.asHex()}, version: $mayorVersion.$minorVersion, sectionLength: $sectionLength');
        }
      case enhancedPacketBlockType:
        {
          final blockTotalLength = reader.getUint32();
          final interfaceId = reader.getUint32();
          final timestampHigh = reader.getUint32();
          final timestampLow = reader.getUint32();
          final millis = timestampHigh << 4 | timestampLow;
          final timeStamp =
              DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true);
          final capturedPacketLength = reader.getUint32();
          final originalPacketLength = reader.getUint32();
          final remainingBytes = reader.getBytes(blockTotalLength - 28 - 4);

          if (i == 42) {
            print('$timeStamp');
            print('i: $i, sectionTotalLength: ${blockTotalLength.asHex()}');
            print(remainingBytes.dumpAsHex());
          }

          final trailingTotalbytes = reader.getUint32();
        }
      default:
        {
          final blockTotalLength = reader.getUint32();
          final bytestoSkip = blockTotalLength - 8;
          reader.skipBytes(bytestoSkip);
          print("type is ${type.asHex()} and length is $blockTotalLength");
        }
    }

    i++;

    if (i > 60) {
      return;
    }
  }
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