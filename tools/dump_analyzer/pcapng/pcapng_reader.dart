import 'dart:typed_data';

class ByteDataReader {
  int _offset = 0;
  final ByteData _data;
  final Endian _endian;

  ByteDataReader(this._data, this._endian);

  factory ByteDataReader.fromBytes(
    Uint8List bytes, [
    Endian endian = Endian.big,
  ]) {
    return ByteDataReader(ByteData.view(bytes.buffer), endian);
  }

  int getUint8() {
    final result = _data.getUint8(_offset);
    _offset += 1;
    return result;
  }

  int getUint16() {
    final result = _data.getUint16(_offset, _endian);
    _offset += 2;
    return result;
  }

  int getUint32() {
    final result = _data.getUint32(_offset, _endian);
    _offset += 4;
    return result;
  }

  int getUint64() {
    final result = _data.getUint64(_offset, _endian);
    _offset += 8;
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

  Uint8List getRemainingBytes() => getBytes(remainingBytes);

  int get length => _data.lengthInBytes;

  int get remainingBytes => length - _offset;

  void skipBytes(int bytesToSkip) {
    _offset += bytesToSkip;
  }
}

class PcapngReader extends ByteDataReader {
  static const emptyBlockSize = 12;

  PcapngReader(super.data, [super._endian = Endian.little]);

  factory PcapngReader.fromBytes(Uint8List bytes) {
    return PcapngReader(ByteData.view(bytes.buffer));
  }

  bool get hasUnreadBlock => remainingBytes >= emptyBlockSize;

  PcapngReader readBlock() {
    final blockSize = _data.getUint32(_offset + 4, Endian.little);
    final blockBytes = _data.buffer.asByteData(_offset, blockSize);
    skipBytes(blockSize);
    return PcapngReader(blockBytes);
  }
}
