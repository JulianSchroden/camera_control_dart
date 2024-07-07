// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_update_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CameraUpdateEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CameraDescriptor descriptor) descriptorChanged,
    required TResult Function(ControlPropType propType, ControlPropValue value)
        propValueChanged,
    required TResult Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)
        propAllowedValuesChanged,
    required TResult Function(bool isRecording) recordState,
    required TResult Function(AutoFocusMode focusMode) focusMode,
    required TResult Function(int ndValue) ndFilter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CameraDescriptor descriptor)? descriptorChanged,
    TResult? Function(ControlPropType propType, ControlPropValue value)?
        propValueChanged,
    TResult? Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)?
        propAllowedValuesChanged,
    TResult? Function(bool isRecording)? recordState,
    TResult? Function(AutoFocusMode focusMode)? focusMode,
    TResult? Function(int ndValue)? ndFilter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CameraDescriptor descriptor)? descriptorChanged,
    TResult Function(ControlPropType propType, ControlPropValue value)?
        propValueChanged,
    TResult Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)?
        propAllowedValuesChanged,
    TResult Function(bool isRecording)? recordState,
    TResult Function(AutoFocusMode focusMode)? focusMode,
    TResult Function(int ndValue)? ndFilter,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DescriptorChanged value) descriptorChanged,
    required TResult Function(_PropValueChanged value) propValueChanged,
    required TResult Function(_PropAllowedValuesChanged value)
        propAllowedValuesChanged,
    required TResult Function(_RecordStateUpdate value) recordState,
    required TResult Function(_FocusModeUpdate value) focusMode,
    required TResult Function(_NdFilterUpdate value) ndFilter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DescriptorChanged value)? descriptorChanged,
    TResult? Function(_PropValueChanged value)? propValueChanged,
    TResult? Function(_PropAllowedValuesChanged value)?
        propAllowedValuesChanged,
    TResult? Function(_RecordStateUpdate value)? recordState,
    TResult? Function(_FocusModeUpdate value)? focusMode,
    TResult? Function(_NdFilterUpdate value)? ndFilter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DescriptorChanged value)? descriptorChanged,
    TResult Function(_PropValueChanged value)? propValueChanged,
    TResult Function(_PropAllowedValuesChanged value)? propAllowedValuesChanged,
    TResult Function(_RecordStateUpdate value)? recordState,
    TResult Function(_FocusModeUpdate value)? focusMode,
    TResult Function(_NdFilterUpdate value)? ndFilter,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraUpdateEventCopyWith<$Res> {
  factory $CameraUpdateEventCopyWith(
          CameraUpdateEvent value, $Res Function(CameraUpdateEvent) then) =
      _$CameraUpdateEventCopyWithImpl<$Res, CameraUpdateEvent>;
}

/// @nodoc
class _$CameraUpdateEventCopyWithImpl<$Res, $Val extends CameraUpdateEvent>
    implements $CameraUpdateEventCopyWith<$Res> {
  _$CameraUpdateEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$DescriptorChangedImplCopyWith<$Res> {
  factory _$$DescriptorChangedImplCopyWith(_$DescriptorChangedImpl value,
          $Res Function(_$DescriptorChangedImpl) then) =
      __$$DescriptorChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CameraDescriptor descriptor});
}

/// @nodoc
class __$$DescriptorChangedImplCopyWithImpl<$Res>
    extends _$CameraUpdateEventCopyWithImpl<$Res, _$DescriptorChangedImpl>
    implements _$$DescriptorChangedImplCopyWith<$Res> {
  __$$DescriptorChangedImplCopyWithImpl(_$DescriptorChangedImpl _value,
      $Res Function(_$DescriptorChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? descriptor = null,
  }) {
    return _then(_$DescriptorChangedImpl(
      null == descriptor
          ? _value.descriptor
          : descriptor // ignore: cast_nullable_to_non_nullable
              as CameraDescriptor,
    ));
  }
}

/// @nodoc

class _$DescriptorChangedImpl implements _DescriptorChanged {
  const _$DescriptorChangedImpl(this.descriptor);

  @override
  final CameraDescriptor descriptor;

  @override
  String toString() {
    return 'CameraUpdateEvent.descriptorChanged(descriptor: $descriptor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DescriptorChangedImpl &&
            (identical(other.descriptor, descriptor) ||
                other.descriptor == descriptor));
  }

  @override
  int get hashCode => Object.hash(runtimeType, descriptor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DescriptorChangedImplCopyWith<_$DescriptorChangedImpl> get copyWith =>
      __$$DescriptorChangedImplCopyWithImpl<_$DescriptorChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CameraDescriptor descriptor) descriptorChanged,
    required TResult Function(ControlPropType propType, ControlPropValue value)
        propValueChanged,
    required TResult Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)
        propAllowedValuesChanged,
    required TResult Function(bool isRecording) recordState,
    required TResult Function(AutoFocusMode focusMode) focusMode,
    required TResult Function(int ndValue) ndFilter,
  }) {
    return descriptorChanged(descriptor);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CameraDescriptor descriptor)? descriptorChanged,
    TResult? Function(ControlPropType propType, ControlPropValue value)?
        propValueChanged,
    TResult? Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)?
        propAllowedValuesChanged,
    TResult? Function(bool isRecording)? recordState,
    TResult? Function(AutoFocusMode focusMode)? focusMode,
    TResult? Function(int ndValue)? ndFilter,
  }) {
    return descriptorChanged?.call(descriptor);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CameraDescriptor descriptor)? descriptorChanged,
    TResult Function(ControlPropType propType, ControlPropValue value)?
        propValueChanged,
    TResult Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)?
        propAllowedValuesChanged,
    TResult Function(bool isRecording)? recordState,
    TResult Function(AutoFocusMode focusMode)? focusMode,
    TResult Function(int ndValue)? ndFilter,
    required TResult orElse(),
  }) {
    if (descriptorChanged != null) {
      return descriptorChanged(descriptor);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DescriptorChanged value) descriptorChanged,
    required TResult Function(_PropValueChanged value) propValueChanged,
    required TResult Function(_PropAllowedValuesChanged value)
        propAllowedValuesChanged,
    required TResult Function(_RecordStateUpdate value) recordState,
    required TResult Function(_FocusModeUpdate value) focusMode,
    required TResult Function(_NdFilterUpdate value) ndFilter,
  }) {
    return descriptorChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DescriptorChanged value)? descriptorChanged,
    TResult? Function(_PropValueChanged value)? propValueChanged,
    TResult? Function(_PropAllowedValuesChanged value)?
        propAllowedValuesChanged,
    TResult? Function(_RecordStateUpdate value)? recordState,
    TResult? Function(_FocusModeUpdate value)? focusMode,
    TResult? Function(_NdFilterUpdate value)? ndFilter,
  }) {
    return descriptorChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DescriptorChanged value)? descriptorChanged,
    TResult Function(_PropValueChanged value)? propValueChanged,
    TResult Function(_PropAllowedValuesChanged value)? propAllowedValuesChanged,
    TResult Function(_RecordStateUpdate value)? recordState,
    TResult Function(_FocusModeUpdate value)? focusMode,
    TResult Function(_NdFilterUpdate value)? ndFilter,
    required TResult orElse(),
  }) {
    if (descriptorChanged != null) {
      return descriptorChanged(this);
    }
    return orElse();
  }
}

abstract class _DescriptorChanged implements CameraUpdateEvent {
  const factory _DescriptorChanged(final CameraDescriptor descriptor) =
      _$DescriptorChangedImpl;

  CameraDescriptor get descriptor;
  @JsonKey(ignore: true)
  _$$DescriptorChangedImplCopyWith<_$DescriptorChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PropValueChangedImplCopyWith<$Res> {
  factory _$$PropValueChangedImplCopyWith(_$PropValueChangedImpl value,
          $Res Function(_$PropValueChangedImpl) then) =
      __$$PropValueChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ControlPropType propType, ControlPropValue value});
}

/// @nodoc
class __$$PropValueChangedImplCopyWithImpl<$Res>
    extends _$CameraUpdateEventCopyWithImpl<$Res, _$PropValueChangedImpl>
    implements _$$PropValueChangedImplCopyWith<$Res> {
  __$$PropValueChangedImplCopyWithImpl(_$PropValueChangedImpl _value,
      $Res Function(_$PropValueChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? propType = null,
    Object? value = null,
  }) {
    return _then(_$PropValueChangedImpl(
      null == propType
          ? _value.propType
          : propType // ignore: cast_nullable_to_non_nullable
              as ControlPropType,
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as ControlPropValue,
    ));
  }
}

/// @nodoc

class _$PropValueChangedImpl implements _PropValueChanged {
  const _$PropValueChangedImpl(this.propType, this.value);

  @override
  final ControlPropType propType;
  @override
  final ControlPropValue value;

  @override
  String toString() {
    return 'CameraUpdateEvent.propValueChanged(propType: $propType, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PropValueChangedImpl &&
            (identical(other.propType, propType) ||
                other.propType == propType) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, propType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PropValueChangedImplCopyWith<_$PropValueChangedImpl> get copyWith =>
      __$$PropValueChangedImplCopyWithImpl<_$PropValueChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CameraDescriptor descriptor) descriptorChanged,
    required TResult Function(ControlPropType propType, ControlPropValue value)
        propValueChanged,
    required TResult Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)
        propAllowedValuesChanged,
    required TResult Function(bool isRecording) recordState,
    required TResult Function(AutoFocusMode focusMode) focusMode,
    required TResult Function(int ndValue) ndFilter,
  }) {
    return propValueChanged(propType, value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CameraDescriptor descriptor)? descriptorChanged,
    TResult? Function(ControlPropType propType, ControlPropValue value)?
        propValueChanged,
    TResult? Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)?
        propAllowedValuesChanged,
    TResult? Function(bool isRecording)? recordState,
    TResult? Function(AutoFocusMode focusMode)? focusMode,
    TResult? Function(int ndValue)? ndFilter,
  }) {
    return propValueChanged?.call(propType, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CameraDescriptor descriptor)? descriptorChanged,
    TResult Function(ControlPropType propType, ControlPropValue value)?
        propValueChanged,
    TResult Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)?
        propAllowedValuesChanged,
    TResult Function(bool isRecording)? recordState,
    TResult Function(AutoFocusMode focusMode)? focusMode,
    TResult Function(int ndValue)? ndFilter,
    required TResult orElse(),
  }) {
    if (propValueChanged != null) {
      return propValueChanged(propType, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DescriptorChanged value) descriptorChanged,
    required TResult Function(_PropValueChanged value) propValueChanged,
    required TResult Function(_PropAllowedValuesChanged value)
        propAllowedValuesChanged,
    required TResult Function(_RecordStateUpdate value) recordState,
    required TResult Function(_FocusModeUpdate value) focusMode,
    required TResult Function(_NdFilterUpdate value) ndFilter,
  }) {
    return propValueChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DescriptorChanged value)? descriptorChanged,
    TResult? Function(_PropValueChanged value)? propValueChanged,
    TResult? Function(_PropAllowedValuesChanged value)?
        propAllowedValuesChanged,
    TResult? Function(_RecordStateUpdate value)? recordState,
    TResult? Function(_FocusModeUpdate value)? focusMode,
    TResult? Function(_NdFilterUpdate value)? ndFilter,
  }) {
    return propValueChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DescriptorChanged value)? descriptorChanged,
    TResult Function(_PropValueChanged value)? propValueChanged,
    TResult Function(_PropAllowedValuesChanged value)? propAllowedValuesChanged,
    TResult Function(_RecordStateUpdate value)? recordState,
    TResult Function(_FocusModeUpdate value)? focusMode,
    TResult Function(_NdFilterUpdate value)? ndFilter,
    required TResult orElse(),
  }) {
    if (propValueChanged != null) {
      return propValueChanged(this);
    }
    return orElse();
  }
}

abstract class _PropValueChanged implements CameraUpdateEvent {
  const factory _PropValueChanged(
          final ControlPropType propType, final ControlPropValue value) =
      _$PropValueChangedImpl;

  ControlPropType get propType;
  ControlPropValue get value;
  @JsonKey(ignore: true)
  _$$PropValueChangedImplCopyWith<_$PropValueChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PropAllowedValuesChangedImplCopyWith<$Res> {
  factory _$$PropAllowedValuesChangedImplCopyWith(
          _$PropAllowedValuesChangedImpl value,
          $Res Function(_$PropAllowedValuesChangedImpl) then) =
      __$$PropAllowedValuesChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ControlPropType propType, List<ControlPropValue> allowedValues});
}

/// @nodoc
class __$$PropAllowedValuesChangedImplCopyWithImpl<$Res>
    extends _$CameraUpdateEventCopyWithImpl<$Res,
        _$PropAllowedValuesChangedImpl>
    implements _$$PropAllowedValuesChangedImplCopyWith<$Res> {
  __$$PropAllowedValuesChangedImplCopyWithImpl(
      _$PropAllowedValuesChangedImpl _value,
      $Res Function(_$PropAllowedValuesChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? propType = null,
    Object? allowedValues = null,
  }) {
    return _then(_$PropAllowedValuesChangedImpl(
      null == propType
          ? _value.propType
          : propType // ignore: cast_nullable_to_non_nullable
              as ControlPropType,
      null == allowedValues
          ? _value._allowedValues
          : allowedValues // ignore: cast_nullable_to_non_nullable
              as List<ControlPropValue>,
    ));
  }
}

/// @nodoc

class _$PropAllowedValuesChangedImpl implements _PropAllowedValuesChanged {
  const _$PropAllowedValuesChangedImpl(
      this.propType, final List<ControlPropValue> allowedValues)
      : _allowedValues = allowedValues;

  @override
  final ControlPropType propType;
  final List<ControlPropValue> _allowedValues;
  @override
  List<ControlPropValue> get allowedValues {
    if (_allowedValues is EqualUnmodifiableListView) return _allowedValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowedValues);
  }

  @override
  String toString() {
    return 'CameraUpdateEvent.propAllowedValuesChanged(propType: $propType, allowedValues: $allowedValues)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PropAllowedValuesChangedImpl &&
            (identical(other.propType, propType) ||
                other.propType == propType) &&
            const DeepCollectionEquality()
                .equals(other._allowedValues, _allowedValues));
  }

  @override
  int get hashCode => Object.hash(runtimeType, propType,
      const DeepCollectionEquality().hash(_allowedValues));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PropAllowedValuesChangedImplCopyWith<_$PropAllowedValuesChangedImpl>
      get copyWith => __$$PropAllowedValuesChangedImplCopyWithImpl<
          _$PropAllowedValuesChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CameraDescriptor descriptor) descriptorChanged,
    required TResult Function(ControlPropType propType, ControlPropValue value)
        propValueChanged,
    required TResult Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)
        propAllowedValuesChanged,
    required TResult Function(bool isRecording) recordState,
    required TResult Function(AutoFocusMode focusMode) focusMode,
    required TResult Function(int ndValue) ndFilter,
  }) {
    return propAllowedValuesChanged(propType, allowedValues);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CameraDescriptor descriptor)? descriptorChanged,
    TResult? Function(ControlPropType propType, ControlPropValue value)?
        propValueChanged,
    TResult? Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)?
        propAllowedValuesChanged,
    TResult? Function(bool isRecording)? recordState,
    TResult? Function(AutoFocusMode focusMode)? focusMode,
    TResult? Function(int ndValue)? ndFilter,
  }) {
    return propAllowedValuesChanged?.call(propType, allowedValues);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CameraDescriptor descriptor)? descriptorChanged,
    TResult Function(ControlPropType propType, ControlPropValue value)?
        propValueChanged,
    TResult Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)?
        propAllowedValuesChanged,
    TResult Function(bool isRecording)? recordState,
    TResult Function(AutoFocusMode focusMode)? focusMode,
    TResult Function(int ndValue)? ndFilter,
    required TResult orElse(),
  }) {
    if (propAllowedValuesChanged != null) {
      return propAllowedValuesChanged(propType, allowedValues);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DescriptorChanged value) descriptorChanged,
    required TResult Function(_PropValueChanged value) propValueChanged,
    required TResult Function(_PropAllowedValuesChanged value)
        propAllowedValuesChanged,
    required TResult Function(_RecordStateUpdate value) recordState,
    required TResult Function(_FocusModeUpdate value) focusMode,
    required TResult Function(_NdFilterUpdate value) ndFilter,
  }) {
    return propAllowedValuesChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DescriptorChanged value)? descriptorChanged,
    TResult? Function(_PropValueChanged value)? propValueChanged,
    TResult? Function(_PropAllowedValuesChanged value)?
        propAllowedValuesChanged,
    TResult? Function(_RecordStateUpdate value)? recordState,
    TResult? Function(_FocusModeUpdate value)? focusMode,
    TResult? Function(_NdFilterUpdate value)? ndFilter,
  }) {
    return propAllowedValuesChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DescriptorChanged value)? descriptorChanged,
    TResult Function(_PropValueChanged value)? propValueChanged,
    TResult Function(_PropAllowedValuesChanged value)? propAllowedValuesChanged,
    TResult Function(_RecordStateUpdate value)? recordState,
    TResult Function(_FocusModeUpdate value)? focusMode,
    TResult Function(_NdFilterUpdate value)? ndFilter,
    required TResult orElse(),
  }) {
    if (propAllowedValuesChanged != null) {
      return propAllowedValuesChanged(this);
    }
    return orElse();
  }
}

abstract class _PropAllowedValuesChanged implements CameraUpdateEvent {
  const factory _PropAllowedValuesChanged(final ControlPropType propType,
          final List<ControlPropValue> allowedValues) =
      _$PropAllowedValuesChangedImpl;

  ControlPropType get propType;
  List<ControlPropValue> get allowedValues;
  @JsonKey(ignore: true)
  _$$PropAllowedValuesChangedImplCopyWith<_$PropAllowedValuesChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RecordStateUpdateImplCopyWith<$Res> {
  factory _$$RecordStateUpdateImplCopyWith(_$RecordStateUpdateImpl value,
          $Res Function(_$RecordStateUpdateImpl) then) =
      __$$RecordStateUpdateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isRecording});
}

/// @nodoc
class __$$RecordStateUpdateImplCopyWithImpl<$Res>
    extends _$CameraUpdateEventCopyWithImpl<$Res, _$RecordStateUpdateImpl>
    implements _$$RecordStateUpdateImplCopyWith<$Res> {
  __$$RecordStateUpdateImplCopyWithImpl(_$RecordStateUpdateImpl _value,
      $Res Function(_$RecordStateUpdateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRecording = null,
  }) {
    return _then(_$RecordStateUpdateImpl(
      null == isRecording
          ? _value.isRecording
          : isRecording // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RecordStateUpdateImpl implements _RecordStateUpdate {
  const _$RecordStateUpdateImpl(this.isRecording);

  @override
  final bool isRecording;

  @override
  String toString() {
    return 'CameraUpdateEvent.recordState(isRecording: $isRecording)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordStateUpdateImpl &&
            (identical(other.isRecording, isRecording) ||
                other.isRecording == isRecording));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isRecording);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordStateUpdateImplCopyWith<_$RecordStateUpdateImpl> get copyWith =>
      __$$RecordStateUpdateImplCopyWithImpl<_$RecordStateUpdateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CameraDescriptor descriptor) descriptorChanged,
    required TResult Function(ControlPropType propType, ControlPropValue value)
        propValueChanged,
    required TResult Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)
        propAllowedValuesChanged,
    required TResult Function(bool isRecording) recordState,
    required TResult Function(AutoFocusMode focusMode) focusMode,
    required TResult Function(int ndValue) ndFilter,
  }) {
    return recordState(isRecording);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CameraDescriptor descriptor)? descriptorChanged,
    TResult? Function(ControlPropType propType, ControlPropValue value)?
        propValueChanged,
    TResult? Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)?
        propAllowedValuesChanged,
    TResult? Function(bool isRecording)? recordState,
    TResult? Function(AutoFocusMode focusMode)? focusMode,
    TResult? Function(int ndValue)? ndFilter,
  }) {
    return recordState?.call(isRecording);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CameraDescriptor descriptor)? descriptorChanged,
    TResult Function(ControlPropType propType, ControlPropValue value)?
        propValueChanged,
    TResult Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)?
        propAllowedValuesChanged,
    TResult Function(bool isRecording)? recordState,
    TResult Function(AutoFocusMode focusMode)? focusMode,
    TResult Function(int ndValue)? ndFilter,
    required TResult orElse(),
  }) {
    if (recordState != null) {
      return recordState(isRecording);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DescriptorChanged value) descriptorChanged,
    required TResult Function(_PropValueChanged value) propValueChanged,
    required TResult Function(_PropAllowedValuesChanged value)
        propAllowedValuesChanged,
    required TResult Function(_RecordStateUpdate value) recordState,
    required TResult Function(_FocusModeUpdate value) focusMode,
    required TResult Function(_NdFilterUpdate value) ndFilter,
  }) {
    return recordState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DescriptorChanged value)? descriptorChanged,
    TResult? Function(_PropValueChanged value)? propValueChanged,
    TResult? Function(_PropAllowedValuesChanged value)?
        propAllowedValuesChanged,
    TResult? Function(_RecordStateUpdate value)? recordState,
    TResult? Function(_FocusModeUpdate value)? focusMode,
    TResult? Function(_NdFilterUpdate value)? ndFilter,
  }) {
    return recordState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DescriptorChanged value)? descriptorChanged,
    TResult Function(_PropValueChanged value)? propValueChanged,
    TResult Function(_PropAllowedValuesChanged value)? propAllowedValuesChanged,
    TResult Function(_RecordStateUpdate value)? recordState,
    TResult Function(_FocusModeUpdate value)? focusMode,
    TResult Function(_NdFilterUpdate value)? ndFilter,
    required TResult orElse(),
  }) {
    if (recordState != null) {
      return recordState(this);
    }
    return orElse();
  }
}

abstract class _RecordStateUpdate implements CameraUpdateEvent {
  const factory _RecordStateUpdate(final bool isRecording) =
      _$RecordStateUpdateImpl;

  bool get isRecording;
  @JsonKey(ignore: true)
  _$$RecordStateUpdateImplCopyWith<_$RecordStateUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FocusModeUpdateImplCopyWith<$Res> {
  factory _$$FocusModeUpdateImplCopyWith(_$FocusModeUpdateImpl value,
          $Res Function(_$FocusModeUpdateImpl) then) =
      __$$FocusModeUpdateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AutoFocusMode focusMode});
}

/// @nodoc
class __$$FocusModeUpdateImplCopyWithImpl<$Res>
    extends _$CameraUpdateEventCopyWithImpl<$Res, _$FocusModeUpdateImpl>
    implements _$$FocusModeUpdateImplCopyWith<$Res> {
  __$$FocusModeUpdateImplCopyWithImpl(
      _$FocusModeUpdateImpl _value, $Res Function(_$FocusModeUpdateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? focusMode = null,
  }) {
    return _then(_$FocusModeUpdateImpl(
      null == focusMode
          ? _value.focusMode
          : focusMode // ignore: cast_nullable_to_non_nullable
              as AutoFocusMode,
    ));
  }
}

/// @nodoc

class _$FocusModeUpdateImpl implements _FocusModeUpdate {
  const _$FocusModeUpdateImpl(this.focusMode);

  @override
  final AutoFocusMode focusMode;

  @override
  String toString() {
    return 'CameraUpdateEvent.focusMode(focusMode: $focusMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FocusModeUpdateImpl &&
            (identical(other.focusMode, focusMode) ||
                other.focusMode == focusMode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, focusMode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FocusModeUpdateImplCopyWith<_$FocusModeUpdateImpl> get copyWith =>
      __$$FocusModeUpdateImplCopyWithImpl<_$FocusModeUpdateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CameraDescriptor descriptor) descriptorChanged,
    required TResult Function(ControlPropType propType, ControlPropValue value)
        propValueChanged,
    required TResult Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)
        propAllowedValuesChanged,
    required TResult Function(bool isRecording) recordState,
    required TResult Function(AutoFocusMode focusMode) focusMode,
    required TResult Function(int ndValue) ndFilter,
  }) {
    return focusMode(this.focusMode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CameraDescriptor descriptor)? descriptorChanged,
    TResult? Function(ControlPropType propType, ControlPropValue value)?
        propValueChanged,
    TResult? Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)?
        propAllowedValuesChanged,
    TResult? Function(bool isRecording)? recordState,
    TResult? Function(AutoFocusMode focusMode)? focusMode,
    TResult? Function(int ndValue)? ndFilter,
  }) {
    return focusMode?.call(this.focusMode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CameraDescriptor descriptor)? descriptorChanged,
    TResult Function(ControlPropType propType, ControlPropValue value)?
        propValueChanged,
    TResult Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)?
        propAllowedValuesChanged,
    TResult Function(bool isRecording)? recordState,
    TResult Function(AutoFocusMode focusMode)? focusMode,
    TResult Function(int ndValue)? ndFilter,
    required TResult orElse(),
  }) {
    if (focusMode != null) {
      return focusMode(this.focusMode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DescriptorChanged value) descriptorChanged,
    required TResult Function(_PropValueChanged value) propValueChanged,
    required TResult Function(_PropAllowedValuesChanged value)
        propAllowedValuesChanged,
    required TResult Function(_RecordStateUpdate value) recordState,
    required TResult Function(_FocusModeUpdate value) focusMode,
    required TResult Function(_NdFilterUpdate value) ndFilter,
  }) {
    return focusMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DescriptorChanged value)? descriptorChanged,
    TResult? Function(_PropValueChanged value)? propValueChanged,
    TResult? Function(_PropAllowedValuesChanged value)?
        propAllowedValuesChanged,
    TResult? Function(_RecordStateUpdate value)? recordState,
    TResult? Function(_FocusModeUpdate value)? focusMode,
    TResult? Function(_NdFilterUpdate value)? ndFilter,
  }) {
    return focusMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DescriptorChanged value)? descriptorChanged,
    TResult Function(_PropValueChanged value)? propValueChanged,
    TResult Function(_PropAllowedValuesChanged value)? propAllowedValuesChanged,
    TResult Function(_RecordStateUpdate value)? recordState,
    TResult Function(_FocusModeUpdate value)? focusMode,
    TResult Function(_NdFilterUpdate value)? ndFilter,
    required TResult orElse(),
  }) {
    if (focusMode != null) {
      return focusMode(this);
    }
    return orElse();
  }
}

abstract class _FocusModeUpdate implements CameraUpdateEvent {
  const factory _FocusModeUpdate(final AutoFocusMode focusMode) =
      _$FocusModeUpdateImpl;

  AutoFocusMode get focusMode;
  @JsonKey(ignore: true)
  _$$FocusModeUpdateImplCopyWith<_$FocusModeUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NdFilterUpdateImplCopyWith<$Res> {
  factory _$$NdFilterUpdateImplCopyWith(_$NdFilterUpdateImpl value,
          $Res Function(_$NdFilterUpdateImpl) then) =
      __$$NdFilterUpdateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int ndValue});
}

/// @nodoc
class __$$NdFilterUpdateImplCopyWithImpl<$Res>
    extends _$CameraUpdateEventCopyWithImpl<$Res, _$NdFilterUpdateImpl>
    implements _$$NdFilterUpdateImplCopyWith<$Res> {
  __$$NdFilterUpdateImplCopyWithImpl(
      _$NdFilterUpdateImpl _value, $Res Function(_$NdFilterUpdateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ndValue = null,
  }) {
    return _then(_$NdFilterUpdateImpl(
      null == ndValue
          ? _value.ndValue
          : ndValue // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$NdFilterUpdateImpl implements _NdFilterUpdate {
  const _$NdFilterUpdateImpl(this.ndValue);

  @override
  final int ndValue;

  @override
  String toString() {
    return 'CameraUpdateEvent.ndFilter(ndValue: $ndValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NdFilterUpdateImpl &&
            (identical(other.ndValue, ndValue) || other.ndValue == ndValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ndValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NdFilterUpdateImplCopyWith<_$NdFilterUpdateImpl> get copyWith =>
      __$$NdFilterUpdateImplCopyWithImpl<_$NdFilterUpdateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CameraDescriptor descriptor) descriptorChanged,
    required TResult Function(ControlPropType propType, ControlPropValue value)
        propValueChanged,
    required TResult Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)
        propAllowedValuesChanged,
    required TResult Function(bool isRecording) recordState,
    required TResult Function(AutoFocusMode focusMode) focusMode,
    required TResult Function(int ndValue) ndFilter,
  }) {
    return ndFilter(ndValue);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CameraDescriptor descriptor)? descriptorChanged,
    TResult? Function(ControlPropType propType, ControlPropValue value)?
        propValueChanged,
    TResult? Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)?
        propAllowedValuesChanged,
    TResult? Function(bool isRecording)? recordState,
    TResult? Function(AutoFocusMode focusMode)? focusMode,
    TResult? Function(int ndValue)? ndFilter,
  }) {
    return ndFilter?.call(ndValue);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CameraDescriptor descriptor)? descriptorChanged,
    TResult Function(ControlPropType propType, ControlPropValue value)?
        propValueChanged,
    TResult Function(
            ControlPropType propType, List<ControlPropValue> allowedValues)?
        propAllowedValuesChanged,
    TResult Function(bool isRecording)? recordState,
    TResult Function(AutoFocusMode focusMode)? focusMode,
    TResult Function(int ndValue)? ndFilter,
    required TResult orElse(),
  }) {
    if (ndFilter != null) {
      return ndFilter(ndValue);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DescriptorChanged value) descriptorChanged,
    required TResult Function(_PropValueChanged value) propValueChanged,
    required TResult Function(_PropAllowedValuesChanged value)
        propAllowedValuesChanged,
    required TResult Function(_RecordStateUpdate value) recordState,
    required TResult Function(_FocusModeUpdate value) focusMode,
    required TResult Function(_NdFilterUpdate value) ndFilter,
  }) {
    return ndFilter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DescriptorChanged value)? descriptorChanged,
    TResult? Function(_PropValueChanged value)? propValueChanged,
    TResult? Function(_PropAllowedValuesChanged value)?
        propAllowedValuesChanged,
    TResult? Function(_RecordStateUpdate value)? recordState,
    TResult? Function(_FocusModeUpdate value)? focusMode,
    TResult? Function(_NdFilterUpdate value)? ndFilter,
  }) {
    return ndFilter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DescriptorChanged value)? descriptorChanged,
    TResult Function(_PropValueChanged value)? propValueChanged,
    TResult Function(_PropAllowedValuesChanged value)? propAllowedValuesChanged,
    TResult Function(_RecordStateUpdate value)? recordState,
    TResult Function(_FocusModeUpdate value)? focusMode,
    TResult Function(_NdFilterUpdate value)? ndFilter,
    required TResult orElse(),
  }) {
    if (ndFilter != null) {
      return ndFilter(this);
    }
    return orElse();
  }
}

abstract class _NdFilterUpdate implements CameraUpdateEvent {
  const factory _NdFilterUpdate(final int ndValue) = _$NdFilterUpdateImpl;

  int get ndValue;
  @JsonKey(ignore: true)
  _$$NdFilterUpdateImplCopyWith<_$NdFilterUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
