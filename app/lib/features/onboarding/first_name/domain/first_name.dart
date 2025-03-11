import 'package:app/l10n/l10n.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

const _firstNameRegex =
    r'''^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžæÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$''';

final class FirstName extends Equatable {
  const FirstName._({required this.value});
  const FirstName.unsafe(this.value);
  static Either<String, FirstName> create(final String input) {
    final inputTrimmed = input.trim();

    if (inputTrimmed.isEmpty) {
      return left(Localisation.firstNameEmpty);
    }
    if (!RegExp(_firstNameRegex).hasMatch(inputTrimmed)) {
      return left(Localisation.firstNameInvalid);
    }

    return right(FirstName._(value: inputTrimmed));
  }

  final String value;

  @override
  List<Object> get props => [value];
}
