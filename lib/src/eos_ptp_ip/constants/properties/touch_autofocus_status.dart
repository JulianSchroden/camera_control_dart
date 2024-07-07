import '../../../common/extensions/list_extensions.dart';
import '../ptp_property.dart';

enum TouchAutofocusStatus implements EosValue {
  faceTracking(0x20),
  tracking(0x30),
  focusFound(0x31),
  focusNotFound(0x32);

  const TouchAutofocusStatus(this.native);

  @override
  final int native;

  @override
  String get common => name;
}

TouchAutofocusStatus? mapTouchAutofocusStatus(int value) =>
    TouchAutofocusStatus.values
        .firstWhereOrNull((enumEntry) => value == enumEntry.native);
