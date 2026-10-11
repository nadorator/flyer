// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_need.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlatformNeed _$PlatformNeedFromJson(Map<String, dynamic> json) =>
    _PlatformNeed(
      platform: $enumDecode(_$PlatformEnumMap, json['platform']),
      type: $enumDecode(_$NeedTypeEnumMap, json['type']),
      status:
          $enumDecodeNullable(_$NeedStatusEnumMap, json['status']) ??
          NeedStatus.missing,
      assetUrl: json['asset_url'] as String?,
    );

Map<String, dynamic> _$PlatformNeedToJson(_PlatformNeed instance) =>
    <String, dynamic>{
      'platform': _$PlatformEnumMap[instance.platform]!,
      'type': _$NeedTypeEnumMap[instance.type]!,
      'status': _$NeedStatusEnumMap[instance.status]!,
      'asset_url': instance.assetUrl,
    };

const _$PlatformEnumMap = {
  Platform.instagram: 'instagram',
  Platform.facebook: 'facebook',
  Platform.tiktok: 'tiktok',
  Platform.linkedin: 'linkedin',
  Platform.googleBusiness: 'google_business',
  Platform.localGroups: 'local_groups',
  Platform.storePage: 'store_page',
  Platform.printA4: 'print_a4',
};

const _$NeedTypeEnumMap = {
  NeedType.photo: 'photo',
  NeedType.video: 'video',
  NeedType.audio: 'audio',
  NeedType.text: 'text',
};

const _$NeedStatusEnumMap = {
  NeedStatus.missing: 'missing',
  NeedStatus.provided: 'provided',
  NeedStatus.generated: 'generated',
};
