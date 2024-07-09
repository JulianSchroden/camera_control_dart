import 'dart:typed_data';

import '../../common/extensions/list_extensions.dart';
import '../../common/property_control/control_prop_value.dart';
import '../extensions/dump_bytes_extensions.dart';
import '../extensions/int_as_hex_string_extension.dart';

class EosPtpIntPropValue extends ControlPropValue {
  final String commonValue;
  final int nativeValue;

  const EosPtpIntPropValue(this.commonValue, this.nativeValue);

  @override
  String get value => commonValue;

  @override
  List<Object?> get props => [commonValue, nativeValue];

  @override
  String toString() {
    return 'EosPtpIntPropValue(commonValue: $commonValue, nativeValue: $nativeValue)';
  }
}

class EosPtpMovieRecordingFormatPropValue extends ControlPropValue {
  final List<int> values;

  const EosPtpMovieRecordingFormatPropValue({
    required this.values,
  });

  @override
  List<Object?> get props => [values];

  @override
  String get value => '';

  @override
  String toString() {
    return 'MovieRecordingFormatPropValue($values)';
  }

  List<Diff> diff(EosPtpMovieRecordingFormatPropValue oldPropValue) {
    return values.indexed
        .map((indexedValue) {
          final (index, value) = indexedValue;
          final oldValue = oldPropValue.values[index];
          if (value != oldValue) {
            return Diff(index: index, value: value, oldValue: oldValue);
          }
          return null;
        })
        .whereNotNull()
        .toList();
  }
}

class Diff {
  final int index;
  final int value;
  final int oldValue;

  Diff({required this.index, required this.value, required this.oldValue});

  @override
  String toString() {
    return '$index changed from ${oldValue.asHex()} ($oldValue) to ${value.asHex()} ($value)';
  }
}

class FallbackPropValue extends ControlPropValue {
  final Uint8List payload;

  const FallbackPropValue(this.payload);

  @override
  List<Object?> get props => [payload];

  @override
  String get value => payload.dumpAsHex();

  @override
  String toString() {
    return 'FallbackPropValue(payload: ${payload.dumpAsHex()})';
  }
}
