import 'package:app/core/address/address.dart';
import 'package:app/core/address/geocoding_repository.dart';
import 'package:app/core/presentation/widgets/composants/address/bloc/address_bloc.dart';
import 'package:app/core/presentation/widgets/composants/address/bloc/address_event.dart';
import 'package:app/core/presentation/widgets/composants/address/bloc/address_state.dart';
import 'package:app/core/presentation/widgets/composants/address/user_address_repository.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class AddressSearchWithSaveWidget extends StatelessWidget {
  const AddressSearchWithSaveWidget({super.key, required this.onSelected});

  final AutocompleteOnSelected<Address> onSelected;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => AddressBloc(UserAddressRepository(context.read()))..add(const AddressFetchRequested()),
    child: _Content(onSelected: onSelected),
  );
}

class _Content extends StatelessWidget {
  const _Content({required this.onSelected});

  final AutocompleteOnSelected<Address> onSelected;

  @override
  Widget build(final BuildContext context) => BlocConsumer<AddressBloc, AddressState>(
    builder: (final context, final state) => switch (state.status) {
      AddressStatus.initial => const SizedBox.shrink(),
      AddressStatus.loaded => _Loaded(onSelected: onSelected),
    },
    listener: (final context, final state) => onSelected(state.address!),
    listenWhen: (final previous, final current) =>
        previous.status == AddressStatus.initial &&
        current.status == AddressStatus.loaded &&
        current.address != null &&
        current.address!.isFull,
  );
}

class _Loaded extends StatelessWidget {
  const _Loaded({required this.onSelected});

  final AutocompleteOnSelected<Address> onSelected;

  @override
  Widget build(final BuildContext context) => Column(
    spacing: DsfrSpacings.s1w,
    children: [
      _Autocomplete(onSelected: onSelected),
      if (context.select<AddressBloc, bool>((final bloc) => bloc.state.isAddressModified)) const _SaveButton(),
    ],
  );
}

class _Autocomplete extends StatelessWidget {
  const _Autocomplete({required this.onSelected});

  final AutocompleteOnSelected<Address> onSelected;

  @override
  Widget build(final BuildContext context) => BlocSelector<AddressBloc, AddressState, String?>(
    selector: (final state) {
      final address = state.address;
      if (address == null || !address.isFull) {
        return null;
      }

      return address.label;
    },
    builder: (final context, final address) => FnvAutocomplete(
      initialValue: address,
      displayStringForOption: (final option) => option.label,
      onSearch: (final query) => context.read<GeocodingRepository>().search(query),
      onSelected: (final option) {
        context.read<AddressBloc>().add(AddressSelected(option));
        onSelected(option);
      },
    ),
  );
}

class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(final BuildContext context) => FnvCallout(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s2w,
      children: [
        const Text(Localisation.choisirCommeAdressePrincipaleDescription, style: DsfrTextStyle.bodyMd(color: DsfrColors.grey50)),
        DsfrButton(
          label: Localisation.choisirCommeAdressePrincipale,
          icon: DsfrIcons.deviceSaveFill,
          variant: DsfrButtonVariant.secondary,
          size: DsfrComponentSize.lg,
          onPressed: () => context.read<AddressBloc>().add(const AddressSaveRequested()),
        ),
      ],
    ),
  );
}
