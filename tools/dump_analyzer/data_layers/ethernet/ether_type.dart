enum EhterType {
  ipv4,
}

extension EtherTypeValueExtension on EhterType {
  int get value {
    switch (this) {
      case EhterType.ipv4:
        return 0x0800;
    }
  }
}
