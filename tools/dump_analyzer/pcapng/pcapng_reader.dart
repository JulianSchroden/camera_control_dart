import 'dart:typed_data';

class PcapngReader {
  int _offset = 0;
  final ByteData _data;

  static const emptyBlockSize = 12;

  PcapngReader(this._data);

  factory PcapngReader.fromBytes(Uint8List bytes) {
    return PcapngReader(ByteData.view(bytes.buffer));
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

  int get remainingBytes => length - _offset;

  bool get hasUnreadBlock => remainingBytes >= emptyBlockSize;

  PcapngReader readBlock() {
    final blockSize = _data.getUint32(_offset + 4, Endian.little);
    final blockBytes = _data.buffer.asByteData(_offset, blockSize);
    skipBytes(blockSize);
    return PcapngReader(blockBytes);
  }

  void skipBytes(int bytesToSkip) {
    _offset += bytesToSkip;
  }
}
