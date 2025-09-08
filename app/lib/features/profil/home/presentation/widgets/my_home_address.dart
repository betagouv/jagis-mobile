import 'package:app/core/address/address.dart';
import 'package:app/core/helpers/text_scaler.dart';
import 'package:app/core/presentation/widgets/composants/address/address_search_widget.dart';
import 'package:app/features/communes/municipality.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_bloc.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_event.dart';
import 'package:app/features/profil/home/presentation/widgets/my_home_title_and_content.dart';
import 'package:app/l10n/l10n.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MyHomeAddress extends StatelessWidget {
  const MyHomeAddress({super.key, required this.address, required this.municipalities});

  final Address address;
  final List<Municipality> municipalities;

  @override
  Widget build(final BuildContext context) => MyHomeTitleAndContent(
    title: Localisation.ouHabitezVous,
    content: address.isFull
        ? _MyHomeFullAddress(address: address)
        : _MyHomePostalCodeAndMunicipality(
            postCode: address.postCode,
            municipalities: municipalities,
            cityCode: address.cityCode,
          ),
  );
}

class _MyHomeFullAddress extends StatelessWidget {
  const _MyHomeFullAddress({required this.address});

  final Address address;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s2w,
    children: [
      AddressSearchWidget(
        address: address,
        onSelected: (final option) => context.read<MyHomeBloc>().add(
          MyHomeDataUpdated(
            latitude: option.latitude,
            longitude: option.longitude,
            houseNumber: option.houseNumber,
            street: option.street,
            postCode: option.postCode,
            cityCode: option.cityCode,
          ),
        ),
      ),
      DsfrButton(
        label: Localisation.supprimerMonAdresse,
        variant: DsfrButtonVariant.secondary,
        size: DsfrComponentSize.lg,
        onPressed: () => context.read<MyHomeBloc>().add(const MyHomeAddressDeletePressed()),
      ),
    ],
  );
}

class _MyHomePostalCodeAndMunicipality extends StatefulWidget {
  const _MyHomePostalCodeAndMunicipality({required this.postCode, required this.municipalities, required this.cityCode});

  final String postCode;
  final List<Municipality> municipalities;
  final String cityCode;

  @override
  State<_MyHomePostalCodeAndMunicipality> createState() => _MyHomePostalCodeAndMunicipalityState();
}

class _MyHomePostalCodeAndMunicipalityState extends State<_MyHomePostalCodeAndMunicipality> {
  final _textEditingController = TextEditingController();

  void _handleCommune(final BuildContext context, final String? value) {
    if (value == null) {
      return;
    }
    context.read<MyHomeBloc>().add(MyHomeDataUpdated(cityCode: value));
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    _textEditingController.text = widget.municipalities.length == 1
        ? widget.municipalities.first.label
        : (widget.municipalities.firstWhereOrNull((final e) => e.code == widget.cityCode)?.label ?? '');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: adjustTextSize(context, 97),
          child: DsfrInput(
            label: Localisation.codePostal,
            initialValue: widget.postCode,
            onChanged: (final value) {
              context.read<MyHomeBloc>().add(MyHomeCodePostalChange(value));
              _textEditingController.clear();
            },
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(5)],
            autofillHints: const [AutofillHints.postalCode],
          ),
        ),
        const SizedBox(width: DsfrSpacings.s2w),
        Expanded(
          child: DsfrSelect(
            label: Localisation.commune,
            dropdownMenuEntries: widget.municipalities
                .map((final e) => DropdownMenuEntry(value: e.code, label: e.label))
                .toList(),
            onSelected: (final value) => _handleCommune(context, value),
            controller: _textEditingController,
          ),
        ),
      ],
    );
  }
}
