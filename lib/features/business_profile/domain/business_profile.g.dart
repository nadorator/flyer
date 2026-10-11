// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusinessProfile _$BusinessProfileFromJson(Map<String, dynamic> json) =>
    _BusinessProfile(
      id: json['id'] as String,
      ownerId: json['owner_id'] as String,
      name: json['name'] as String,
      siret: json['siret'] as String?,
      logoUrl: json['logo_url'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      socials:
          (json['socials'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const <String, String>{},
      colors:
          (json['colors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$BusinessProfileToJson(_BusinessProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.ownerId,
      'name': instance.name,
      'siret': instance.siret,
      'logo_url': instance.logoUrl,
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
      'website': instance.website,
      'socials': instance.socials,
      'colors': instance.colors,
    };
