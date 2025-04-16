import 'dart:async';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/features/gamification/domain/gamification.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rxdart/rxdart.dart';

class GamificationRepository {
  GamificationRepository({required final DioHttpClient client, required final MessageBus messageBus}) : _client = client {
    final topics = [resetPointsTopic, startFirstTimeQuestionsToPersonalizeActionsTopic, actionDoneTopic];
    _subscription = MergeStream(topics.map(messageBus.subscribe)).listen((final event) async {
      await refresh();
    });
  }

  final DioHttpClient _client;
  late final StreamSubscription<String> _subscription;

  Future<Either<Exception, Unit>> refresh() async {
    final response = await _client.get(Endpoints.gamification);
    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des points'));
    }

    final json = response.data as Map<String, dynamic>;

    final gamification = Gamification(
      points: (json['points'] as num).toInt(),
      badges: json['badges'] == null ? 0 : (json['badges'] as List).length,
    );

    _gamificationSubject.add(gamification);

    return const Right(unit);
  }

  final _gamificationSubject = BehaviorSubject<Gamification>();

  Stream<Gamification> gamification() => _gamificationSubject.stream;

  // ignore: unused-code
  Future<void> dispose() async {
    await _subscription.cancel();
    await _gamificationSubject.close();
  }
}
