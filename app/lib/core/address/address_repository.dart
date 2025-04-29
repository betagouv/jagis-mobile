// ignore_for_file: avoid-accessing-collections-by-constant-index

import 'package:app/core/address/address.dart';
import 'package:dio/dio.dart';

class AddressRepository {
  const AddressRepository(this._client);

  final Dio _client;

  Future<Iterable<Address>> search(final String query) async {
    if (query == '' || query.length < 3) {
      return const Iterable.empty();
    }
    final response = await _client.get<dynamic>(
      Uri.parse(
        'https://data.geopf.fr/geocodage/search?q=$query&index=address&type=housenumber&limit=4&autocomplete=1',
      ).toString(),
    );
    if (response.statusCode != 200) {
      return const Iterable.empty();
    }

    final body = response.data as Map<String, dynamic>;
    final features = (body['features'] as List<dynamic>).cast<Map<String, dynamic>>();
    final results = <Address>[];
    for (final feature in features) {
      final coordinates = ((feature['geometry'] as Map<String, dynamic>)['coordinates'] as List<dynamic>).cast<double>();
      final properties = feature['properties'] as Map<String, dynamic>;
      results.add(
        Address(
          latitude: coordinates.last,
          longitude: coordinates.first,
          houseNumber: properties['housenumber'] as String,
          street: properties['street'] as String,
          postCode: properties['postcode'] as String,
          city: properties['city'] as String,
          cityCode: properties['citycode'] as String,
        ),
      );
    }

    return results;
  }
}
