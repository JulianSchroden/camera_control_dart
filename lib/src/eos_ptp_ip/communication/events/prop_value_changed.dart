import '../../../common/property_control/control_prop_type.dart';
import '../../../common/property_control/control_prop_value.dart';
import '../../extensions/int_as_hex_string_extension.dart';
import 'ptp_event.dart';

class PropValueChanged extends PtpEvent {
  final int propCode;
  final ControlPropType? propType;
  final ControlPropValue propValue;

  const PropValueChanged(this.propCode, this.propType, this.propValue);

  @override
  List<Object?> get props => [propType, propValue];

  @override
  String toString() {
    return 'PropValueChanged(propCode: ${propCode.asHex()}, propType: $propType, propValue: $propValue)';
  }
}
