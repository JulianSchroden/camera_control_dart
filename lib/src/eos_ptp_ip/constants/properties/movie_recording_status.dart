import '../ptp_property.dart';

enum MovieRecordingStatus implements EosValue {
  notRecording(0x03),
  recording(0x04);

  @override
  final int native;
  @override
  String get common => name;

  const MovieRecordingStatus(this.native);
}
