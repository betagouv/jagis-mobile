// ignore_for_file: avoid-long-parameter-list

import 'dart:io';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/car_simulator/domain/car_simulator.dart';
import 'package:app/features/car_simulator/infrastructure/car_simulator_mapper.dart';
import 'package:fpdart/fpdart.dart';

class CarSimulatorRepository {
  const CarSimulatorRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;
  Future<Either<Exception, CarInfos>> computeCurrentCar() async {
    final response = await _client.get(Endpoints.carSimulatorComputeCurrentCar);

    if (response.statusCode! >= HttpStatus.badRequest) {
      return Left(Exception('Erreur lors de la simulation de la voiture actuelle: $response'));
    }

    final json = response.data as Map<String, dynamic>;

    return Right(CarInfosMapper.fromJson(json));
  }

  Future<Either<Exception, List<CarSimulatorOption>>> computeCarSimulatorOptions() async {
    final response = await _client.get(Endpoints.carSimulatorComputeOptions);

    if (response.statusCode! >= HttpStatus.badRequest) {
      return Left(Exception('Erreur lors de la simulation des options: $response'));
    }

    final json = response.data as List<dynamic>;

    return Right(json.map(CarSimulatorOptionMapper.fromJson).toList());
  }
}
