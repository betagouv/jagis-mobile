import 'package:app/core/assets/images.dart';
import 'package:app/core/helpers/pattern_formatter.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_bloc.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

const _prmPattern = '## ### ### ### ###';

class WinterPrmForm extends StatelessWidget {
  const WinterPrmForm({super.key});

  @override
  Widget build(final BuildContext context) => Column(
    spacing: DsfrSpacings.s2w,
    children: [
      DsfrInput(
        label: Localisation.numeroDePrm,
        hintText: Localisation.numeroDePrmHint,
        onChanged: (final value) => context.read<WinterBloc>().add(WinterPrmNumberChanged(value.replaceAll(' ', ''))),
        autocorrect: false,
        keyboardType: TextInputType.number,
        inputFormatters: const [PatternFormatter(pattern: _prmPattern)],
      ),
      const _Accordion(),
      DsfrInput(
        label: Localisation.nomDeFamille,
        onChanged: (final value) => context.read<WinterBloc>().add(WinterLastNameChanged(value)),
      ),
    ],
  );
}

class _Accordion extends StatefulWidget {
  const _Accordion();

  @override
  State<_Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<_Accordion> {
  var _isExpanded = false;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: FnvShadows.card),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: FnvAccordion(
        item: FnvAccordionItem(
          headerBuilder: (final isExpanded) => Row(
            spacing: DsfrSpacings.s1v,
            children: [
              const Icon(DsfrIcons.systemInformationLine, size: 20),
              Text(Localisation.ouTrouverCeNumero, style: DsfrTextStyle.bodyMd(color: DsfrColorDecisions.textLabelGrey(context))),
            ],
          ),
          body: const Row(
            spacing: DsfrSpacings.s1w,
            children: [
              Expanded(child: _OnYourBill()),
              Expanded(child: _OnYourLinkyMeter()),
            ],
          ),
        ),
        isExpanded: _isExpanded,
        onAccordionCallback: (final isExpanded) => setState(() => _isExpanded = isExpanded),
      ),
    ),
  );
}

class _OnYourBill extends StatelessWidget {
  const _OnYourBill();

  @override
  Widget build(final BuildContext context) => const _Explication(
    assetName: AssetImages.factureEngie,
    title: Localisation.surVotreFacture,
    detail: Localisation.surVotreFactureDetail,
  );
}

class _OnYourLinkyMeter extends StatelessWidget {
  const _OnYourLinkyMeter();

  @override
  Widget build(final BuildContext context) => const _Explication(
    assetName: AssetImages.compteurLinky,
    title: Localisation.surVotreCompteurLinky,
    detail: Localisation.surVotreCompteurLinkyDetail,
  );
}

class _Explication extends StatelessWidget {
  const _Explication({required this.assetName, required this.title, required this.detail});

  final String assetName;
  final String title;
  final String detail;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s1w,
    children: [
      FnvImage.asset(assetName, height: 120),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: DsfrTextStyle.bodySmBold(color: DsfrColorDecisions.textLabelGrey(context))),
          Text(detail, style: DsfrTextStyle.bodySm(color: DsfrColorDecisions.textLabelGrey(context))),
        ],
      ),
    ],
  );
}
