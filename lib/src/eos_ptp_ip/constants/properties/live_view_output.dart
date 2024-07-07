import '../ptp_property.dart';

enum LiveViewOutput implements EosValue {
  none(0x0),
  camera(0x1),
  host(0x2),
  cameraAndHost(0x3);

  const LiveViewOutput(this.native);

  @override
  final int native;

  @override
  String get common => name;
}
