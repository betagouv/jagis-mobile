import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvDateOnlyInput extends StatefulWidget {
  const FnvDateOnlyInput({super.key});

  @override
  State<FnvDateOnlyInput> createState() => _FnvDateOnlyInputState();
}

class _FnvDateOnlyInputState extends State<FnvDateOnlyInput> {
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();

  final _dayFocusNode = FocusNode();
  final _monthFocusNode = FocusNode();
  final _yearFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _dayController.addListener(_onDayChanged);
    _monthController.addListener(_onMonthChanged);
    _yearController.addListener(_onYearChanged);
  }

  void _onDayChanged() {
    if (_dayController.text.length == 2) {
      _monthFocusNode.requestFocus();
    }
  }

  void _onMonthChanged() {
    if (_monthController.text.length == 2) {
      _yearFocusNode.requestFocus();
    }
  }

  void _onYearChanged() {
    if (_yearController.text.length == 4) {
      _yearFocusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();

    _dayFocusNode.dispose();
    _monthFocusNode.dispose();
    _yearFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s2w,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsfrSpacings.s1w,
        children: [
          Text('Date de naissance', style: DsfrTextStyle.bodyMd(color: DsfrColorDecisions.textLabelGrey(context))),
          Text(
            'Indication : texte de description additionnel',
            style: DsfrTextStyle.bodyXs(color: DsfrColorDecisions.textMentionGrey(context)),
          ),
        ],
      ),
      Row(
        spacing: DsfrSpacings.s2w,
        children: [
          SizedBox(
            width: 80,
            child: DsfrInput(
              label: 'Jour',
              hintText: 'Exemple : 14',
              controller: _dayController,
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(2)],
              focusNode: _dayFocusNode,
            ),
          ),
          SizedBox(
            width: 80,
            child: DsfrInput(
              label: 'Mois',
              hintText: 'Exemple : 12',
              controller: _monthController,
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(2)],
              focusNode: _monthFocusNode,
            ),
          ),
          SizedBox(
            width: 110,
            child: DsfrInput(
              label: 'Année',
              hintText: 'Exemple : 1984',
              controller: _yearController,
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(4)],
              focusNode: _yearFocusNode,
            ),
          ),
        ],
      ),
    ],
  );
}
