// ignore_for_file: avoid-long-parameter-list, avoid-nullable-interpolation

import 'package:app/core/address/address.dart';
import 'package:app/core/address/address_mapper.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:fpdart/fpdart.dart';

class UserAddressRepository {
  const UserAddressRepository(this._client);

  final DioHttpClient _client;

  Future<Either<Exception, Address>> fetchAddress() async {
    final response = await _client.get(Endpoints.logement);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération de l’adresse'));
    }

    final json = response.data as Map<String, dynamic>;

    return Right(AddressMapper.fromJson(json));
  }

  Future<Either<Exception, Unit>> modifyAddress(final Address address) async {
    final response = await _client.patch(
      Endpoints.logement,
      data: {
        'rue': address.street,
        'numero_rue': address.houseNumber,
        'code_postal': address.postCode,
        'code_commune': address.cityCode,
        'latitude': address.latitude,
        'longitude': address.longitude,
      },
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : Left(Exception('Erreur lors de la mise à jour de l’adresse'));
  }
}
