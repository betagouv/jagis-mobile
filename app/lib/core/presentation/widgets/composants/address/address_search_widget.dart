import 'package:app/core/address/address.dart';
import 'package:app/core/address/geocoding_repository.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressSearchWidget extends StatelessWidget {
  const AddressSearchWidget({super.key, this.enabled = true, this.address, required this.onSelected});

  final bool enabled;
  final Address? address;
  final AutocompleteOnSelected<Address> onSelected;

  @override
  Widget build(final BuildContext context) => FnvAutocomplete(
    enabled: enabled,
    initialValue: address?.label,
    displayStringForOption: (final option) => option.label,
    onSearch: (final query) => context.read<GeocodingRepository>().search(query),
    onSelected: onSelected,
  );
}
