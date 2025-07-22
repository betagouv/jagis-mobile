import 'package:app/core/address/address.dart';
import 'package:app/core/presentation/widgets/composants/address/address_search_widget.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_bloc.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_event.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class WinterAddressForm extends StatelessWidget {
  const WinterAddressForm({super.key, required this.current});

  final WinterForm current;

  @override
  Widget build(final BuildContext context) => Column(
    spacing: DsfrSpacings.s2w,
    children: [
      _AddressInput(
        label: Localisation.lAdresseDeMaResidencePrincipale,
        address: current.address,
        isAddressCompleted: current.isAddressCompleted,
        onSelected: (final option) => context.read<WinterBloc>().add(WinterAddressChanged(option)),
      ),
      DsfrInput(
        label: Localisation.nomDeFamille,
        onChanged: (final value) => context.read<WinterBloc>().add(WinterLastNameChanged(value)),
      ),
    ],
  );
}

class _AddressInput extends StatelessWidget {
  const _AddressInput({required this.label, required this.address, required this.isAddressCompleted, required this.onSelected});

  final String label;
  final Address? address;
  final bool isAddressCompleted;
  final AutocompleteOnSelected<Address> onSelected;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s1w,
    children: [
      Text(label, style: DsfrTextStyle.bodyMd(color: DsfrColorDecisions.textLabelGrey(context))),
      AddressSearchWidget(enabled: !isAddressCompleted, address: address, onSelected: onSelected),
      Row(
        spacing: DsfrSpacings.s1v,
        children: [
          Icon(DsfrIcons.systemFrInfoFill, size: DsfrSpacings.s2w, color: DsfrColorDecisions.borderPlainInfo(context)),
          Flexible(
            child: Text(
              isAddressCompleted ? Localisation.winterAddressInfoRemplie : Localisation.winterAddressInfoVide,
              style: DsfrTextStyle.bodyXs(color: DsfrColorDecisions.textDefaultInfo(context)),
            ),
          ),
        ],
      ),
    ],
  );
}
