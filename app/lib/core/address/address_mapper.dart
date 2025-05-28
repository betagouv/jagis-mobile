import 'package:app/core/address/address.dart';
import 'package:app/core/helpers/json_mapper.dart';

abstract final class AddressMapper {
  const AddressMapper._();

  static Address fromJson(final Map<String, dynamic> json) => Address(
    latitude: JsonHelpers.toNullable<num>(json, 'latitude')?.toDouble(),
    longitude: JsonHelpers.toNullable<num>(json, 'longitude')?.toDouble(),
    houseNumber: JsonHelpers.toNullable(json, 'numero_rue'),
    street: JsonHelpers.toNullable(json, 'rue'),
    postCode: json['code_postal'] as String,
    city: json['commune_label'] as String,
    cityCode: json['code_commune'] as String,
  );
}
