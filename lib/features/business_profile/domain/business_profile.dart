import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_profile.freezed.dart';
part 'business_profile.g.dart';

/// Profil entreprise du photographe (FL-102). Alimente les flyers générés.
@freezed
abstract class BusinessProfile with _$BusinessProfile {
  const factory BusinessProfile({
    required String id,
    required String ownerId,
    required String name,
    String? siret,
    String? logoUrl,
    String? address,
    String? phone,
    String? email,
    String? website,
    @Default(<String, String>{}) Map<String, String> socials,
    @Default(<String>[]) List<String> colors,
  }) = _BusinessProfile;

  factory BusinessProfile.fromJson(Map<String, dynamic> json) =>
      _$BusinessProfileFromJson(json);
}
