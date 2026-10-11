// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailySchedule {

 DateTime get day; String get startTime; String get endTime;
/// Create a copy of DailySchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyScheduleCopyWith<DailySchedule> get copyWith => _$DailyScheduleCopyWithImpl<DailySchedule>(this as DailySchedule, _$identity);

  /// Serializes this DailySchedule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailySchedule&&(identical(other.day, day) || other.day == day)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,startTime,endTime);

@override
String toString() {
  return 'DailySchedule(day: $day, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class $DailyScheduleCopyWith<$Res>  {
  factory $DailyScheduleCopyWith(DailySchedule value, $Res Function(DailySchedule) _then) = _$DailyScheduleCopyWithImpl;
@useResult
$Res call({
 DateTime day, String startTime, String endTime
});




}
/// @nodoc
class _$DailyScheduleCopyWithImpl<$Res>
    implements $DailyScheduleCopyWith<$Res> {
  _$DailyScheduleCopyWithImpl(this._self, this._then);

  final DailySchedule _self;
  final $Res Function(DailySchedule) _then;

/// Create a copy of DailySchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(_self.copyWith(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DailySchedule].
extension DailySchedulePatterns on DailySchedule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailySchedule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailySchedule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailySchedule value)  $default,){
final _that = this;
switch (_that) {
case _DailySchedule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailySchedule value)?  $default,){
final _that = this;
switch (_that) {
case _DailySchedule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime day,  String startTime,  String endTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailySchedule() when $default != null:
return $default(_that.day,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime day,  String startTime,  String endTime)  $default,) {final _that = this;
switch (_that) {
case _DailySchedule():
return $default(_that.day,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime day,  String startTime,  String endTime)?  $default,) {final _that = this;
switch (_that) {
case _DailySchedule() when $default != null:
return $default(_that.day,_that.startTime,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailySchedule extends DailySchedule {
  const _DailySchedule({required this.day, required this.startTime, required this.endTime}): super._();
  factory _DailySchedule.fromJson(Map<String, dynamic> json) => _$DailyScheduleFromJson(json);

@override final  DateTime day;
@override final  String startTime;
@override final  String endTime;

/// Create a copy of DailySchedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyScheduleCopyWith<_DailySchedule> get copyWith => __$DailyScheduleCopyWithImpl<_DailySchedule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyScheduleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailySchedule&&(identical(other.day, day) || other.day == day)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,startTime,endTime);

@override
String toString() {
  return 'DailySchedule(day: $day, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class _$DailyScheduleCopyWith<$Res> implements $DailyScheduleCopyWith<$Res> {
  factory _$DailyScheduleCopyWith(_DailySchedule value, $Res Function(_DailySchedule) _then) = __$DailyScheduleCopyWithImpl;
@override @useResult
$Res call({
 DateTime day, String startTime, String endTime
});




}
/// @nodoc
class __$DailyScheduleCopyWithImpl<$Res>
    implements _$DailyScheduleCopyWith<$Res> {
  __$DailyScheduleCopyWithImpl(this._self, this._then);

  final _DailySchedule _self;
  final $Res Function(_DailySchedule) _then;

/// Create a copy of DailySchedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(_DailySchedule(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Event {

 String get id; String get businessId; String get name; String get description; DateTime get startDate; DateTime get endDate; List<DailySchedule> get schedules; String? get venueName; String? get partnerStoreName; double? get price; String? get bookingUrl; String? get slug; EventStatus get status;
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventCopyWith<Event> get copyWith => _$EventCopyWithImpl<Event>(this as Event, _$identity);

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Event&&(identical(other.id, id) || other.id == id)&&(identical(other.businessId, businessId) || other.businessId == businessId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&const DeepCollectionEquality().equals(other.schedules, schedules)&&(identical(other.venueName, venueName) || other.venueName == venueName)&&(identical(other.partnerStoreName, partnerStoreName) || other.partnerStoreName == partnerStoreName)&&(identical(other.price, price) || other.price == price)&&(identical(other.bookingUrl, bookingUrl) || other.bookingUrl == bookingUrl)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,businessId,name,description,startDate,endDate,const DeepCollectionEquality().hash(schedules),venueName,partnerStoreName,price,bookingUrl,slug,status);

@override
String toString() {
  return 'Event(id: $id, businessId: $businessId, name: $name, description: $description, startDate: $startDate, endDate: $endDate, schedules: $schedules, venueName: $venueName, partnerStoreName: $partnerStoreName, price: $price, bookingUrl: $bookingUrl, slug: $slug, status: $status)';
}


}

/// @nodoc
abstract mixin class $EventCopyWith<$Res>  {
  factory $EventCopyWith(Event value, $Res Function(Event) _then) = _$EventCopyWithImpl;
@useResult
$Res call({
 String id, String businessId, String name, String description, DateTime startDate, DateTime endDate, List<DailySchedule> schedules, String? venueName, String? partnerStoreName, double? price, String? bookingUrl, String? slug, EventStatus status
});




}
/// @nodoc
class _$EventCopyWithImpl<$Res>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._self, this._then);

  final Event _self;
  final $Res Function(Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? businessId = null,Object? name = null,Object? description = null,Object? startDate = null,Object? endDate = null,Object? schedules = null,Object? venueName = freezed,Object? partnerStoreName = freezed,Object? price = freezed,Object? bookingUrl = freezed,Object? slug = freezed,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,businessId: null == businessId ? _self.businessId : businessId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,schedules: null == schedules ? _self.schedules : schedules // ignore: cast_nullable_to_non_nullable
as List<DailySchedule>,venueName: freezed == venueName ? _self.venueName : venueName // ignore: cast_nullable_to_non_nullable
as String?,partnerStoreName: freezed == partnerStoreName ? _self.partnerStoreName : partnerStoreName // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,bookingUrl: freezed == bookingUrl ? _self.bookingUrl : bookingUrl // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EventStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [Event].
extension EventPatterns on Event {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Event value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Event() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Event value)  $default,){
final _that = this;
switch (_that) {
case _Event():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Event value)?  $default,){
final _that = this;
switch (_that) {
case _Event() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String businessId,  String name,  String description,  DateTime startDate,  DateTime endDate,  List<DailySchedule> schedules,  String? venueName,  String? partnerStoreName,  double? price,  String? bookingUrl,  String? slug,  EventStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.businessId,_that.name,_that.description,_that.startDate,_that.endDate,_that.schedules,_that.venueName,_that.partnerStoreName,_that.price,_that.bookingUrl,_that.slug,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String businessId,  String name,  String description,  DateTime startDate,  DateTime endDate,  List<DailySchedule> schedules,  String? venueName,  String? partnerStoreName,  double? price,  String? bookingUrl,  String? slug,  EventStatus status)  $default,) {final _that = this;
switch (_that) {
case _Event():
return $default(_that.id,_that.businessId,_that.name,_that.description,_that.startDate,_that.endDate,_that.schedules,_that.venueName,_that.partnerStoreName,_that.price,_that.bookingUrl,_that.slug,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String businessId,  String name,  String description,  DateTime startDate,  DateTime endDate,  List<DailySchedule> schedules,  String? venueName,  String? partnerStoreName,  double? price,  String? bookingUrl,  String? slug,  EventStatus status)?  $default,) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.businessId,_that.name,_that.description,_that.startDate,_that.endDate,_that.schedules,_that.venueName,_that.partnerStoreName,_that.price,_that.bookingUrl,_that.slug,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Event extends Event {
  const _Event({required this.id, required this.businessId, required this.name, required this.description, required this.startDate, required this.endDate, final  List<DailySchedule> schedules = const <DailySchedule>[], this.venueName, this.partnerStoreName, this.price, this.bookingUrl, this.slug, this.status = EventStatus.draft}): _schedules = schedules,super._();
  factory _Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

@override final  String id;
@override final  String businessId;
@override final  String name;
@override final  String description;
@override final  DateTime startDate;
@override final  DateTime endDate;
 final  List<DailySchedule> _schedules;
@override@JsonKey() List<DailySchedule> get schedules {
  if (_schedules is EqualUnmodifiableListView) return _schedules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_schedules);
}

@override final  String? venueName;
@override final  String? partnerStoreName;
@override final  double? price;
@override final  String? bookingUrl;
@override final  String? slug;
@override@JsonKey() final  EventStatus status;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventCopyWith<_Event> get copyWith => __$EventCopyWithImpl<_Event>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Event&&(identical(other.id, id) || other.id == id)&&(identical(other.businessId, businessId) || other.businessId == businessId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&const DeepCollectionEquality().equals(other._schedules, _schedules)&&(identical(other.venueName, venueName) || other.venueName == venueName)&&(identical(other.partnerStoreName, partnerStoreName) || other.partnerStoreName == partnerStoreName)&&(identical(other.price, price) || other.price == price)&&(identical(other.bookingUrl, bookingUrl) || other.bookingUrl == bookingUrl)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,businessId,name,description,startDate,endDate,const DeepCollectionEquality().hash(_schedules),venueName,partnerStoreName,price,bookingUrl,slug,status);

@override
String toString() {
  return 'Event(id: $id, businessId: $businessId, name: $name, description: $description, startDate: $startDate, endDate: $endDate, schedules: $schedules, venueName: $venueName, partnerStoreName: $partnerStoreName, price: $price, bookingUrl: $bookingUrl, slug: $slug, status: $status)';
}


}

/// @nodoc
abstract mixin class _$EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$EventCopyWith(_Event value, $Res Function(_Event) _then) = __$EventCopyWithImpl;
@override @useResult
$Res call({
 String id, String businessId, String name, String description, DateTime startDate, DateTime endDate, List<DailySchedule> schedules, String? venueName, String? partnerStoreName, double? price, String? bookingUrl, String? slug, EventStatus status
});




}
/// @nodoc
class __$EventCopyWithImpl<$Res>
    implements _$EventCopyWith<$Res> {
  __$EventCopyWithImpl(this._self, this._then);

  final _Event _self;
  final $Res Function(_Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? businessId = null,Object? name = null,Object? description = null,Object? startDate = null,Object? endDate = null,Object? schedules = null,Object? venueName = freezed,Object? partnerStoreName = freezed,Object? price = freezed,Object? bookingUrl = freezed,Object? slug = freezed,Object? status = null,}) {
  return _then(_Event(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,businessId: null == businessId ? _self.businessId : businessId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,schedules: null == schedules ? _self._schedules : schedules // ignore: cast_nullable_to_non_nullable
as List<DailySchedule>,venueName: freezed == venueName ? _self.venueName : venueName // ignore: cast_nullable_to_non_nullable
as String?,partnerStoreName: freezed == partnerStoreName ? _self.partnerStoreName : partnerStoreName // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,bookingUrl: freezed == bookingUrl ? _self.bookingUrl : bookingUrl // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EventStatus,
  ));
}


}

// dart format on
