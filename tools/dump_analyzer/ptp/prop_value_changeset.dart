import 'package:camera_control_dart/camera_control_dart.dart';
import 'package:camera_control_dart/src/common/extensions/list_extensions.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/communication/events/prop_value_changed.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/extensions/int_as_hex_string_extension.dart';

class PropValueChangeset {
  final int propCode;
  final ControlPropValue? previous;
  final ControlPropValue? current;

  const PropValueChangeset({
    required this.propCode,
    required this.previous,
    required this.current,
  });

  @override
  String toString() {
    return 'PropValueChangeset(propCode: ${propCode.asHex()}, previous: $previous, current: $current)';
  }
}

List<PropValueChangeset> mapChangeset(
  List<PropValueChanged> previousEvents,
  List<PropValueChanged> currentEvents,
) {
  final propCodes = <int>{
    ...previousEvents.map((e) => e.propCode),
    ...currentEvents.map((e) => e.propCode),
  }.toList();

  return propCodes
      .map((propCode) {
        final previousEvent = previousEvents.firstWhereOrNull(
            (previousEvent) => previousEvent.propCode == propCode);
        final matchingEvent = currentEvents.firstWhereOrNull(
            (currentEvent) => currentEvent.propCode == propCode);

        return PropValueChangeset(
          propCode: propCode,
          previous: previousEvent?.propValue,
          current: matchingEvent?.propValue,
        );
      })
      .where((changeSet) => changeSet.previous != changeSet.current)
      .toList();
}
