// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_update_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CameraUpdateResponse {
  List<CameraUpdateEvent> get cameraEvents =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CameraUpdateResponseCopyWith<CameraUpdateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraUpdateResponseCopyWith<$Res> {
  factory $CameraUpdateResponseCopyWith(CameraUpdateResponse value,
          $Res Function(CameraUpdateResponse) then) =
      _$CameraUpdateResponseCopyWithImpl<$Res, CameraUpdateResponse>;
  @useResult
  $Res call({List<CameraUpdateEvent> cameraEvents});
}

/// @nodoc
class _$CameraUpdateResponseCopyWithImpl<$Res,
        $Val extends CameraUpdateResponse>
    implements $CameraUpdateResponseCopyWith<$Res> {
  _$CameraUpdateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cameraEvents = null,
  }) {
    return _then(_value.copyWith(
      cameraEvents: null == cameraEvents
          ? _value.cameraEvents
          : cameraEvents // ignore: cast_nullable_to_non_nullable
              as List<CameraUpdateEvent>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CameraUpdateResponseImplCopyWith<$Res>
    implements $CameraUpdateResponseCopyWith<$Res> {
  factory _$$CameraUpdateResponseImplCopyWith(_$CameraUpdateResponseImpl value,
          $Res Function(_$CameraUpdateResponseImpl) then) =
      __$$CameraUpdateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CameraUpdateEvent> cameraEvents});
}

/// @nodoc
class __$$CameraUpdateResponseImplCopyWithImpl<$Res>
    extends _$CameraUpdateResponseCopyWithImpl<$Res, _$CameraUpdateResponseImpl>
    implements _$$CameraUpdateResponseImplCopyWith<$Res> {
  __$$CameraUpdateResponseImplCopyWithImpl(_$CameraUpdateResponseImpl _value,
      $Res Function(_$CameraUpdateResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cameraEvents = null,
  }) {
    return _then(_$CameraUpdateResponseImpl(
      cameraEvents: null == cameraEvents
          ? _value._cameraEvents
          : cameraEvents // ignore: cast_nullable_to_non_nullable
              as List<CameraUpdateEvent>,
    ));
  }
}

/// @nodoc

class _$CameraUpdateResponseImpl implements _CameraUpdateResponse {
  const _$CameraUpdateResponseImpl(
      {required final List<CameraUpdateEvent> cameraEvents})
      : _cameraEvents = cameraEvents;

  final List<CameraUpdateEvent> _cameraEvents;
  @override
  List<CameraUpdateEvent> get cameraEvents {
    if (_cameraEvents is EqualUnmodifiableListView) return _cameraEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cameraEvents);
  }

  @override
  String toString() {
    return 'CameraUpdateResponse(cameraEvents: $cameraEvents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraUpdateResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._cameraEvents, _cameraEvents));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_cameraEvents));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraUpdateResponseImplCopyWith<_$CameraUpdateResponseImpl>
      get copyWith =>
          __$$CameraUpdateResponseImplCopyWithImpl<_$CameraUpdateResponseImpl>(
              this, _$identity);
}

abstract class _CameraUpdateResponse implements CameraUpdateResponse {
  const factory _CameraUpdateResponse(
          {required final List<CameraUpdateEvent> cameraEvents}) =
      _$CameraUpdateResponseImpl;

  @override
  List<CameraUpdateEvent> get cameraEvents;
  @override
  @JsonKey(ignore: true)
  _$$CameraUpdateResponseImplCopyWith<_$CameraUpdateResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
