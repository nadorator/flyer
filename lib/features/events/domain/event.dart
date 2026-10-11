import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

/// Statut de cycle de vie d'un event.
enum EventStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('published')
  published,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

/// Horaires d'une journée d'event (FL-201). Les heures sont au format `HH:mm`.
@freezed
abstract class DailySchedule with _$DailySchedule {
  const DailySchedule._();

  const factory DailySchedule({
    required DateTime day,
    required String startTime,
    required String endTime,
  }) = _DailySchedule;

  factory DailySchedule.fromJson(Map<String, dynamic> json) =>
      _$DailyScheduleFromJson(json);

  /// Vrai si les deux heures sont bien formées et si `endTime` est
  /// strictement postérieure à `startTime`.
  bool get isValid {
    final start = _minutes(startTime);
    final end = _minutes(endTime);
    return start >= 0 && end >= 0 && end > start;
  }

  static int _minutes(String hhmm) {
    final parts = hhmm.split(':');
    if (parts.length != 2) return -1;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null || h < 0 || h > 23 || m < 0 || m > 59) return -1;
    return h * 60 + m;
  }
}

/// Event organisé par un photographe (FL-201).
@freezed
abstract class Event with _$Event {
  const Event._();

  const factory Event({
    required String id,
    required String businessId,
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    @Default(<DailySchedule>[]) List<DailySchedule> schedules,
    String? venueName,
    String? partnerStoreName,
    double? price,
    String? bookingUrl,
    String? slug,
    @Default(EventStatus.draft) EventStatus status,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  /// Règles de validation du formulaire (FL-201) ; liste vide = valide.
  List<EventValidationError> validate() {
    final errors = <EventValidationError>[];
    if (name.trim().isEmpty) errors.add(EventValidationError.nameRequired);
    if (endDate.isBefore(startDate)) {
      errors.add(EventValidationError.endBeforeStart);
    }
    for (final schedule in schedules) {
      final day = DateTime(schedule.day.year, schedule.day.month, schedule.day.day);
      final start = DateTime(startDate.year, startDate.month, startDate.day);
      final end = DateTime(endDate.year, endDate.month, endDate.day);
      if (day.isBefore(start) || day.isAfter(end)) {
        errors.add(EventValidationError.scheduleOutsideRange);
      }
      if (!schedule.isValid) errors.add(EventValidationError.invalidSchedule);
    }
    return errors.toSet().toList();
  }

  bool get isValid => validate().isEmpty;

  /// Nombre de jours couverts par l'event (bornes incluses).
  int get durationInDays => endDate.difference(startDate).inDays + 1;
}

enum EventValidationError {
  nameRequired,
  endBeforeStart,
  invalidSchedule,
  scheduleOutsideRange,
}

extension EventValidationErrorLabel on EventValidationError {
  String get label => switch (this) {
    EventValidationError.nameRequired => 'Le nom de l\'event est obligatoire.',
    EventValidationError.endBeforeStart =>
      'La date de fin doit être postérieure ou égale à la date de début.',
    EventValidationError.invalidSchedule =>
      'L\'heure de fin doit être postérieure à l\'heure de début.',
    EventValidationError.scheduleOutsideRange =>
      'Un horaire est en dehors de la plage de dates de l\'event.',
  };
}
