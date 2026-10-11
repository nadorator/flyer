import 'package:freezed_annotation/freezed_annotation.dart';

part 'platform_need.freezed.dart';
part 'platform_need.g.dart';

/// Plateformes de diffusion d'un event (FL-401).
enum Platform {
  @JsonValue('instagram')
  instagram,
  @JsonValue('facebook')
  facebook,
  @JsonValue('tiktok')
  tiktok,
  @JsonValue('linkedin')
  linkedin,
  @JsonValue('google_business')
  googleBusiness,
  @JsonValue('local_groups')
  localGroups,
  @JsonValue('store_page')
  storePage,
  @JsonValue('print_a4')
  printA4,
}

/// Type de contenu nécessaire sur une plateforme.
enum NeedType {
  @JsonValue('photo')
  photo,
  @JsonValue('video')
  video,
  @JsonValue('audio')
  audio,
  @JsonValue('text')
  text,
}

/// État d'un besoin : manquant, fourni par le photographe ou généré par l'IA.
enum NeedStatus {
  @JsonValue('missing')
  missing,
  @JsonValue('provided')
  provided,
  @JsonValue('generated')
  generated,
}

extension PlatformInfo on Platform {
  String get label => switch (this) {
    Platform.instagram => 'Instagram',
    Platform.facebook => 'Facebook',
    Platform.tiktok => 'TikTok',
    Platform.linkedin => 'LinkedIn',
    Platform.googleBusiness => 'Google Business',
    Platform.localGroups => 'Groupes locaux',
    Platform.storePage => 'Page du magasin',
    Platform.printA4 => 'Affiche A4',
  };

  /// Besoins attendus par défaut pour la plateforme (source de la matrice).
  List<NeedType> get defaultNeeds => switch (this) {
    Platform.instagram => const [NeedType.photo, NeedType.text],
    Platform.facebook => const [NeedType.photo, NeedType.text],
    Platform.tiktok => const [NeedType.video, NeedType.audio, NeedType.text],
    Platform.linkedin => const [NeedType.photo, NeedType.text],
    Platform.googleBusiness => const [NeedType.photo, NeedType.text],
    Platform.localGroups => const [NeedType.photo, NeedType.text],
    Platform.storePage => const [NeedType.photo, NeedType.text],
    Platform.printA4 => const [NeedType.photo, NeedType.text],
  };
}

/// Une cellule de la matrice « plateforme × besoin » (FL-401 / FL-402).
@freezed
abstract class PlatformNeed with _$PlatformNeed {
  const factory PlatformNeed({
    required Platform platform,
    required NeedType type,
    @Default(NeedStatus.missing) NeedStatus status,
    String? assetUrl,
  }) = _PlatformNeed;

  factory PlatformNeed.fromJson(Map<String, dynamic> json) =>
      _$PlatformNeedFromJson(json);

  /// Construit la matrice initiale (tout « manquant ») pour les plateformes
  /// sélectionnées.
  static List<PlatformNeed> initialMatrix(Iterable<Platform> platforms) => [
    for (final platform in platforms)
      for (final type in platform.defaultNeeds)
        PlatformNeed(platform: platform, type: type),
  ];
}
