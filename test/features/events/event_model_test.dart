import 'package:flutter_test/flutter_test.dart';
import 'package:flyer/features/events/domain/event.dart';

void main() {
  final start = DateTime(2026, 12, 14);
  final end = DateTime(2026, 12, 15);

  Event buildEvent({
    String name = 'Séance photo de Noël',
    DateTime? startDate,
    DateTime? endDate,
    List<DailySchedule> schedules = const [],
  }) => Event(
    id: 'evt-1',
    businessId: 'biz-1',
    name: name,
    description: 'Photos de vos animaux en magasin',
    startDate: startDate ?? start,
    endDate: endDate ?? end,
    schedules: schedules,
    venueName: 'Zooplus Part-Dieu',
    partnerStoreName: 'Zooplus',
    price: 25,
    bookingUrl: 'https://calendly.com/camille',
  );

  group('Event JSON', () {
    test('sérialise puis désérialise à l\'identique', () {
      final event = buildEvent(
        schedules: [
          DailySchedule(day: start, startTime: '10:00', endTime: '18:00'),
          DailySchedule(day: end, startTime: '10:00', endTime: '17:00'),
        ],
      );

      final json = event.toJson();
      final restored = Event.fromJson(json);

      expect(restored, equals(event));
      expect(json['status'], 'draft');
      expect((json['schedules'] as List).length, 2);
    });

    test('désérialise le statut depuis sa valeur snake_case', () {
      final json = buildEvent().toJson()..['status'] = 'published';
      expect(Event.fromJson(json).status, EventStatus.published);
    });
  });

  group('Event validation', () {
    test('un event cohérent est valide', () {
      final event = buildEvent(
        schedules: [
          DailySchedule(day: start, startTime: '10:00', endTime: '18:00'),
        ],
      );
      expect(event.isValid, isTrue);
      expect(event.durationInDays, 2);
    });

    test('date de fin avant date de début → erreur', () {
      final event = buildEvent(startDate: end, endDate: start);
      expect(event.validate(), contains(EventValidationError.endBeforeStart));
      expect(event.isValid, isFalse);
    });

    test('date de fin égale à la date de début → valide', () {
      final event = buildEvent(startDate: start, endDate: start);
      expect(event.isValid, isTrue);
      expect(event.durationInDays, 1);
    });

    test('nom vide → erreur', () {
      expect(
        buildEvent(name: '   ').validate(),
        contains(EventValidationError.nameRequired),
      );
    });

    test('horaire avec fin avant début → erreur', () {
      final event = buildEvent(
        schedules: [
          DailySchedule(day: start, startTime: '18:00', endTime: '10:00'),
        ],
      );
      expect(event.validate(), contains(EventValidationError.invalidSchedule));
    });

    test('horaire mal formé → erreur', () {
      final schedule = DailySchedule(
        day: start,
        startTime: '10h',
        endTime: '18:00',
      );
      expect(schedule.isValid, isFalse);
    });

    test('horaire hors de la plage de dates → erreur', () {
      final event = buildEvent(
        schedules: [
          DailySchedule(
            day: DateTime(2026, 12, 20),
            startTime: '10:00',
            endTime: '18:00',
          ),
        ],
      );
      expect(
        event.validate(),
        contains(EventValidationError.scheduleOutsideRange),
      );
    });

    test('les erreurs sont dédoublonnées et libellées en français', () {
      final event = buildEvent(
        schedules: [
          DailySchedule(day: start, startTime: '18:00', endTime: '10:00'),
          DailySchedule(day: end, startTime: '18:00', endTime: '10:00'),
        ],
      );
      final errors = event.validate();
      expect(errors, [EventValidationError.invalidSchedule]);
      expect(errors.single.label, contains('heure de fin'));
    });
  });
}
