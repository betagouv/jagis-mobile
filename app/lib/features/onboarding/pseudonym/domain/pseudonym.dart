import 'package:app/l10n/l10n.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

const _pseudonymRegex =
    r'''^[0-9a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžæÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð,.'-\s]{3,21}$''';

final class Pseudonym extends Equatable {
  const Pseudonym._({required this.value});
  static Either<String, Pseudonym> create(final String input) {
    final inputTrimmed = input.trim();

    if (inputTrimmed.isEmpty) {
      return left(Localisation.pseudonymEmpty);
    }
    if (!RegExp(_pseudonymRegex).hasMatch(inputTrimmed)) {
      return left(Localisation.pseudonymInvalid);
    }

    return right(Pseudonym._(value: inputTrimmed));
  }

  final String value;

  @override
  List<Object> get props => [value];
}
