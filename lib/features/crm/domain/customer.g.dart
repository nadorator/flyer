// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Pet _$PetFromJson(Map<String, dynamic> json) => _Pet(
  id: json['id'] as String,
  customerId: json['customer_id'] as String,
  name: json['name'] as String,
  species: json['species'] as String?,
);

Map<String, dynamic> _$PetToJson(_Pet instance) => <String, dynamic>{
  'id': instance.id,
  'customer_id': instance.customerId,
  'name': instance.name,
  'species': instance.species,
};

_Customer _$CustomerFromJson(Map<String, dynamic> json) => _Customer(
  id: json['id'] as String,
  businessId: json['business_id'] as String,
  fullName: json['full_name'] as String,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  pets:
      (json['pets'] as List<dynamic>?)
          ?.map((e) => Pet.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Pet>[],
  consentMarketing: json['consent_marketing'] as bool? ?? false,
  consentAt: json['consent_at'] == null
      ? null
      : DateTime.parse(json['consent_at'] as String),
  externalId: json['external_id'] as String?,
);

Map<String, dynamic> _$CustomerToJson(_Customer instance) => <String, dynamic>{
  'id': instance.id,
  'business_id': instance.businessId,
  'full_name': instance.fullName,
  'email': instance.email,
  'phone': instance.phone,
  'tags': instance.tags,
  'pets': instance.pets.map((e) => e.toJson()).toList(),
  'consent_marketing': instance.consentMarketing,
  'consent_at': instance.consentAt?.toIso8601String(),
  'external_id': instance.externalId,
};
