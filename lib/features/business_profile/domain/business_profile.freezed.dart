// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BusinessProfile {

 String get id; String get ownerId; String get name; String? get siret; String? get logoUrl; String? get address; String? get phone; String? get email; String? get website; Map<String, String> get socials; List<String> get colors;
/// Create a copy of BusinessProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessProfileCopyWith<BusinessProfile> get copyWith => _$BusinessProfileCopyWithImpl<BusinessProfile>(this as BusinessProfile, _$identity);

  /// Serializes this BusinessProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.siret, siret) || other.siret == siret)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.address, address) || other.address == address)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.website, website) || other.website == website)&&const DeepCollectionEquality().equals(other.socials, socials)&&const DeepCollectionEquality().equals(other.colors, colors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ownerId,name,siret,logoUrl,address,phone,email,website,const DeepCollectionEquality().hash(socials),const DeepCollectionEquality().hash(colors));

@override
String toString() {
  return 'BusinessProfile(id: $id, ownerId: $ownerId, name: $name, siret: $siret, logoUrl: $logoUrl, address: $address, phone: $phone, email: $email, website: $website, socials: $socials, colors: $colors)';
}


}

/// @nodoc
abstract mixin class $BusinessProfileCopyWith<$Res>  {
  factory $BusinessProfileCopyWith(BusinessProfile value, $Res Function(BusinessProfile) _then) = _$BusinessProfileCopyWithImpl;
@useResult
$Res call({
 String id, String ownerId, String name, String? siret, String? logoUrl, String? address, String? phone, String? email, String? website, Map<String, String> socials, List<String> colors
});




}
/// @nodoc
class _$BusinessProfileCopyWithImpl<$Res>
    implements $BusinessProfileCopyWith<$Res> {
  _$BusinessProfileCopyWithImpl(this._self, this._then);

  final BusinessProfile _self;
  final $Res Function(BusinessProfile) _then;

/// Create a copy of BusinessProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ownerId = null,Object? name = null,Object? siret = freezed,Object? logoUrl = freezed,Object? address = freezed,Object? phone = freezed,Object? email = freezed,Object? website = freezed,Object? socials = null,Object? colors = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,siret: freezed == siret ? _self.siret : siret // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,socials: null == socials ? _self.socials : socials // ignore: cast_nullable_to_non_nullable
as Map<String, String>,colors: null == colors ? _self.colors : colors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [BusinessProfile].
extension BusinessProfilePatterns on BusinessProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessProfile value)  $default,){
final _that = this;
switch (_that) {
case _BusinessProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessProfile value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ownerId,  String name,  String? siret,  String? logoUrl,  String? address,  String? phone,  String? email,  String? website,  Map<String, String> socials,  List<String> colors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessProfile() when $default != null:
return $default(_that.id,_that.ownerId,_that.name,_that.siret,_that.logoUrl,_that.address,_that.phone,_that.email,_that.website,_that.socials,_that.colors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ownerId,  String name,  String? siret,  String? logoUrl,  String? address,  String? phone,  String? email,  String? website,  Map<String, String> socials,  List<String> colors)  $default,) {final _that = this;
switch (_that) {
case _BusinessProfile():
return $default(_that.id,_that.ownerId,_that.name,_that.siret,_that.logoUrl,_that.address,_that.phone,_that.email,_that.website,_that.socials,_that.colors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ownerId,  String name,  String? siret,  String? logoUrl,  String? address,  String? phone,  String? email,  String? website,  Map<String, String> socials,  List<String> colors)?  $default,) {final _that = this;
switch (_that) {
case _BusinessProfile() when $default != null:
return $default(_that.id,_that.ownerId,_that.name,_that.siret,_that.logoUrl,_that.address,_that.phone,_that.email,_that.website,_that.socials,_that.colors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusinessProfile implements BusinessProfile {
  const _BusinessProfile({required this.id, required this.ownerId, required this.name, this.siret, this.logoUrl, this.address, this.phone, this.email, this.website, final  Map<String, String> socials = const <String, String>{}, final  List<String> colors = const <String>[]}): _socials = socials,_colors = colors;
  factory _BusinessProfile.fromJson(Map<String, dynamic> json) => _$BusinessProfileFromJson(json);

@override final  String id;
@override final  String ownerId;
@override final  String name;
@override final  String? siret;
@override final  String? logoUrl;
@override final  String? address;
@override final  String? phone;
@override final  String? email;
@override final  String? website;
 final  Map<String, String> _socials;
@override@JsonKey() Map<String, String> get socials {
  if (_socials is EqualUnmodifiableMapView) return _socials;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_socials);
}

 final  List<String> _colors;
@override@JsonKey() List<String> get colors {
  if (_colors is EqualUnmodifiableListView) return _colors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_colors);
}


/// Create a copy of BusinessProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessProfileCopyWith<_BusinessProfile> get copyWith => __$BusinessProfileCopyWithImpl<_BusinessProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.siret, siret) || other.siret == siret)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.address, address) || other.address == address)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.website, website) || other.website == website)&&const DeepCollectionEquality().equals(other._socials, _socials)&&const DeepCollectionEquality().equals(other._colors, _colors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ownerId,name,siret,logoUrl,address,phone,email,website,const DeepCollectionEquality().hash(_socials),const DeepCollectionEquality().hash(_colors));

@override
String toString() {
  return 'BusinessProfile(id: $id, ownerId: $ownerId, name: $name, siret: $siret, logoUrl: $logoUrl, address: $address, phone: $phone, email: $email, website: $website, socials: $socials, colors: $colors)';
}


}

/// @nodoc
abstract mixin class _$BusinessProfileCopyWith<$Res> implements $BusinessProfileCopyWith<$Res> {
  factory _$BusinessProfileCopyWith(_BusinessProfile value, $Res Function(_BusinessProfile) _then) = __$BusinessProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String ownerId, String name, String? siret, String? logoUrl, String? address, String? phone, String? email, String? website, Map<String, String> socials, List<String> colors
});




}
/// @nodoc
class __$BusinessProfileCopyWithImpl<$Res>
    implements _$BusinessProfileCopyWith<$Res> {
  __$BusinessProfileCopyWithImpl(this._self, this._then);

  final _BusinessProfile _self;
  final $Res Function(_BusinessProfile) _then;

/// Create a copy of BusinessProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ownerId = null,Object? name = null,Object? siret = freezed,Object? logoUrl = freezed,Object? address = freezed,Object? phone = freezed,Object? email = freezed,Object? website = freezed,Object? socials = null,Object? colors = null,}) {
  return _then(_BusinessProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,siret: freezed == siret ? _self.siret : siret // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,socials: null == socials ? _self._socials : socials // ignore: cast_nullable_to_non_nullable
as Map<String, String>,colors: null == colors ? _self._colors : colors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
