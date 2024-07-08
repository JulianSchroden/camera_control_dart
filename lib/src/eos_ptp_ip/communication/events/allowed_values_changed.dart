import '../../../common/property_control/control_prop_type.dart';
import '../../../common/property_control/control_prop_value.dart';
import '../../extensions/int_as_hex_string_extension.dart';
import 'ptp_event.dart';

class AllowedValuesChanged extends PtpEvent {
  final int propCode;
  final ControlPropType? propType;
  final List<ControlPropValue> allowedValues;

  const AllowedValuesChanged(this.propCode, this.propType, this.allowedValues);

  @override
  List<Object?> get props => [propType, allowedValues];

  @override
  String toString() {
    return 'AllowedValuesChanged(propCode: ${propCode.asHex()}, allowedValues: $allowedValues)';
  }
}
