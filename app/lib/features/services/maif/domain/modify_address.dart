import 'package:app/core/address/address.dart';
import 'package:app/features/profil/core/infrastructure/profil_repository.dart';
import 'package:fpdart/fpdart.dart';

class ModifyAddress {
  const ModifyAddress(this._port);

  final ProfilRepository _port;

  Future<Either<Exception, Unit>> run(final Address address) => _port.modifyAddress(address);
}
