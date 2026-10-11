import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

/// Animal d'un client (FL-601).
@freezed
abstract class Pet with _$Pet {
  const factory Pet({
    required String id,
    required String customerId,
    required String name,
    String? species,
  }) = _Pet;

  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);
}

/// Fiche client du CRM léger (FL-601), avec consentement RGPD explicite.
@freezed
abstract class Customer with _$Customer {
  const factory Customer({
    required String id,
    required String businessId,
    required String fullName,
    String? email,
    String? phone,
    @Default(<String>[]) List<String> tags,
    @Default(<Pet>[]) List<Pet> pets,
    @Default(false) bool consentMarketing,
    DateTime? consentAt,
    String? externalId,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
