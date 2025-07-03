import 'package:app/features/services/winter/domain/winter_registration.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_bloc.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_event.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_state.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_address_form.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_form_type_selector.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_prm_form.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class WinterFormWidget extends StatelessWidget {
  const WinterFormWidget({super.key});

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: DsfrSpacings.s3w,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: DsfrSpacings.s2w,
        children: [
          Text(
            Localisation.localiserMonCompteur,
            style: DsfrTextStyle.headline4(color: DsfrColorDecisions.textTitleGrey(context)),
          ),
          const WinterFormTypeSelector(),
        ],
      ),
      BlocSelector<WinterBloc, WinterState, RegistrationType>(
        selector: (final state) {
          final current = state;
          if (current is! WinterForm) {
            return RegistrationType.address;
          }

          return current.formType;
        },
        builder: (final context, final formType) => switch (formType) {
          RegistrationType.address => const WinterAddressForm(),
          RegistrationType.prm => const WinterPrmForm(),
        },
      ),
      DsfrCheckbox(
        label: Localisation.winterJeDeclare,
        size: DsfrComponentSize.sm,
        value: context.select<WinterBloc, bool>((final bloc) {
          final current = bloc.state;
          if (current is! WinterForm) {
            return false;
          }

          return current.isDeclarationChecked;
        }),
        onChanged: (final value) => context.read<WinterBloc>().add(WinterDeclarationChanged(value)),
      ),
      DsfrButton(
        label: Localisation.valider,
        variant: DsfrButtonVariant.primary,
        size: DsfrComponentSize.lg,
        onPressed:
            context.select<WinterBloc, bool>((final bloc) {
              final current = bloc.state;
              if (current is! WinterForm) {
                return false;
              }

              return current.isFormValid;
            })
            ? () => context.read<WinterBloc>().add(const WinterSubmit())
            : null,
      ),
    ],
  );
}
