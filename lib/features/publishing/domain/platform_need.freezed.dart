// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'platform_need.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlatformNeed {

 Platform get platform; NeedType get type; NeedStatus get status; String? get assetUrl;
/// Create a copy of PlatformNeed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformNeedCopyWith<PlatformNeed> get copyWith => _$PlatformNeedCopyWithImpl<PlatformNeed>(this as PlatformNeed, _$identity);

  /// Serializes this PlatformNeed to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformNeed&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.assetUrl, assetUrl) || other.assetUrl == assetUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,platform,type,status,assetUrl);

@override
String toString() {
  return 'PlatformNeed(platform: $platform, type: $type, status: $status, assetUrl: $assetUrl)';
}


}

/// @nodoc
abstract mixin class $PlatformNeedCopyWith<$Res>  {
  factory $PlatformNeedCopyWith(PlatformNeed value, $Res Function(PlatformNeed) _then) = _$PlatformNeedCopyWithImpl;
@useResult
$Res call({
 Platform platform, NeedType type, NeedStatus status, String? assetUrl
});




}
/// @nodoc
class _$PlatformNeedCopyWithImpl<$Res>
    implements $PlatformNeedCopyWith<$Res> {
  _$PlatformNeedCopyWithImpl(this._self, this._then);

  final PlatformNeed _self;
  final $Res Function(PlatformNeed) _then;

/// Create a copy of PlatformNeed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? platform = null,Object? type = null,Object? status = null,Object? assetUrl = freezed,}) {
  return _then(_self.copyWith(
platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as Platform,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NeedType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NeedStatus,assetUrl: freezed == assetUrl ? _self.assetUrl : assetUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlatformNeed].
extension PlatformNeedPatterns on PlatformNeed {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlatformNeed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlatformNeed() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlatformNeed value)  $default,){
final _that = this;
switch (_that) {
case _PlatformNeed():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlatformNeed value)?  $default,){
final _that = this;
switch (_that) {
case _PlatformNeed() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Platform platform,  NeedType type,  NeedStatus status,  String? assetUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlatformNeed() when $default != null:
return $default(_that.platform,_that.type,_that.status,_that.assetUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Platform platform,  NeedType type,  NeedStatus status,  String? assetUrl)  $default,) {final _that = this;
switch (_that) {
case _PlatformNeed():
return $default(_that.platform,_that.type,_that.status,_that.assetUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Platform platform,  NeedType type,  NeedStatus status,  String? assetUrl)?  $default,) {final _that = this;
switch (_that) {
case _PlatformNeed() when $default != null:
return $default(_that.platform,_that.type,_that.status,_that.assetUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlatformNeed implements PlatformNeed {
  const _PlatformNeed({required this.platform, required this.type, this.status = NeedStatus.missing, this.assetUrl});
  factory _PlatformNeed.fromJson(Map<String, dynamic> json) => _$PlatformNeedFromJson(json);

@override final  Platform platform;
@override final  NeedType type;
@override@JsonKey() final  NeedStatus status;
@override final  String? assetUrl;

/// Create a copy of PlatformNeed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformNeedCopyWith<_PlatformNeed> get copyWith => __$PlatformNeedCopyWithImpl<_PlatformNeed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatformNeedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformNeed&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.assetUrl, assetUrl) || other.assetUrl == assetUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,platform,type,status,assetUrl);

@override
String toString() {
  return 'PlatformNeed(platform: $platform, type: $type, status: $status, assetUrl: $assetUrl)';
}


}

/// @nodoc
abstract mixin class _$PlatformNeedCopyWith<$Res> implements $PlatformNeedCopyWith<$Res> {
  factory _$PlatformNeedCopyWith(_PlatformNeed value, $Res Function(_PlatformNeed) _then) = __$PlatformNeedCopyWithImpl;
@override @useResult
$Res call({
 Platform platform, NeedType type, NeedStatus status, String? assetUrl
});




}
/// @nodoc
class __$PlatformNeedCopyWithImpl<$Res>
    implements _$PlatformNeedCopyWith<$Res> {
  __$PlatformNeedCopyWithImpl(this._self, this._then);

  final _PlatformNeed _self;
  final $Res Function(_PlatformNeed) _then;

/// Create a copy of PlatformNeed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? platform = null,Object? type = null,Object? status = null,Object? assetUrl = freezed,}) {
  return _then(_PlatformNeed(
platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as Platform,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NeedType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NeedStatus,assetUrl: freezed == assetUrl ? _self.assetUrl : assetUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
