// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailySchedule _$DailyScheduleFromJson(Map<String, dynamic> json) =>
    _DailySchedule(
      day: DateTime.parse(json['day'] as String),
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
    );

Map<String, dynamic> _$DailyScheduleToJson(_DailySchedule instance) =>
    <String, dynamic>{
      'day': instance.day.toIso8601String(),
      'start_time': instance.startTime,
      'end_time': instance.endTime,
    };

_Event _$EventFromJson(Map<String, dynamic> json) => _Event(
  id: json['id'] as String,
  businessId: json['business_id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  startDate: DateTime.parse(json['start_date'] as String),
  endDate: DateTime.parse(json['end_date'] as String),
  schedules:
      (json['schedules'] as List<dynamic>?)
          ?.map((e) => DailySchedule.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <DailySchedule>[],
  venueName: json['venue_name'] as String?,
  partnerStoreName: json['partner_store_name'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  bookingUrl: json['booking_url'] as String?,
  slug: json['slug'] as String?,
  status:
      $enumDecodeNullable(_$EventStatusEnumMap, json['status']) ??
      EventStatus.draft,
);

Map<String, dynamic> _$EventToJson(_Event instance) => <String, dynamic>{
  'id': instance.id,
  'business_id': instance.businessId,
  'name': instance.name,
  'description': instance.description,
  'start_date': instance.startDate.toIso8601String(),
  'end_date': instance.endDate.toIso8601String(),
  'schedules': instance.schedules.map((e) => e.toJson()).toList(),
  'venue_name': instance.venueName,
  'partner_store_name': instance.partnerStoreName,
  'price': instance.price,
  'booking_url': instance.bookingUrl,
  'slug': instance.slug,
  'status': _$EventStatusEnumMap[instance.status]!,
};

const _$EventStatusEnumMap = {
  EventStatus.draft: 'draft',
  EventStatus.published: 'published',
  EventStatus.completed: 'completed',
  EventStatus.cancelled: 'cancelled',
};
