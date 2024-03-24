class Ipv4Address {
  final int _address;

  const Ipv4Address(this._address);

  @override
  String toString() {
    final chunk1 = (_address >> 24) & 0xFF;
    final chunk2 = (_address >> 16) & 0xFF;
    final chunk3 = (_address >> 8) & 0xFF;
    final chunk4 = _address & 0xFF;

    return '$chunk1.$chunk2.$chunk3.$chunk4';
  }
}
