enum Ip4vProtocol {
  tcp,
}

extension Ip4vProtocolValueExtension on Ip4vProtocol {
  int get value {
    switch (this) {
      case Ip4vProtocol.tcp:
        return 0x6;
    }
  }
}
