import 'package:app/features/services/winter/domain/winter_registration.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_bloc.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_event.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class WinterFormTypeSelector extends StatelessWidget {
  const WinterFormTypeSelector({super.key});

  @override
  Widget build(final BuildContext context) => ColoredBox(
    color: DsfrColors.blueEcume975,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: _RadiosGroup(
        direction: Direction.vertical,
        size: DsfrComponentSize.md,
        values: const {
          RegistrationType.address: Row(
            spacing: DsfrSpacings.s1w,
            children: [
              Flexible(child: Text(Localisation.avecMonAdressePostale)),
              DsfrBadge(label: Localisation.conseille, type: DsfrBadgeType.information, size: DsfrComponentSize.sm),
            ],
          ),
          RegistrationType.prm: Text(Localisation.avecMonNumeroDePrm),
        },
        initialValue: context.select<WinterBloc, RegistrationType>((final bloc) {
          final current = bloc.state;
          if (current is! WinterForm) {
            return RegistrationType.address;
          }

          return current.formType;
        }),
        onChanged: (final value) {
          if (value != null) {
            context.read<WinterBloc>().add(WinterFormTypeChanged(value));
          }
        },
      ),
    ),
  );
}

class _RadiosGroup<T> extends StatefulWidget {
  const _RadiosGroup({
    super.key,
    required this.direction,
    required this.size,
    required this.values,
    this.initialValue,
    required this.onChanged,
  });

  final Direction direction;
  final DsfrComponentSize size;
  final Map<T, Widget> values;
  final T? initialValue;
  final ValueChanged<T?> onChanged;

  @override
  State<_RadiosGroup<T>> createState() => _RadiosGroupState<T>();
}

class _RadiosGroupState<T> extends State<_RadiosGroup<T>> {
  T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(final context) => DsfrGroup(
    direction: widget.direction,
    children: widget.values.entries
        .map(
          (final entry) => _RadioButton<T>(
            size: widget.size,
            groupValue: _value,
            value: entry.key,
            onChanged: (final value) {
              setState(() {
                _value = value;
              });
              widget.onChanged(_value);
            },
            child: entry.value,
          ),
        )
        .toList(),
  );
}

class _RadioButton<T> extends StatelessWidget {
  const _RadioButton({
    super.key,
    required this.size,
    this.groupValue,
    required this.value,
    required this.onChanged,
    required this.child,
  }) : assert(size != DsfrComponentSize.lg);

  final DsfrComponentSize size;
  final Widget child;
  final T? groupValue;
  final T value;
  final ValueChanged<T?> onChanged;

  double _getIconSize() => switch (size) {
    DsfrComponentSize.md => 24.0,
    DsfrComponentSize.sm => 16.0,
    DsfrComponentSize.lg => throw UnimplementedError('Size $size is not implemented'),
  };

  @override
  Widget build(final BuildContext context) => Material(
    color: DsfrColorDecisions.backgroundTransparent(context),
    child: InkWell(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: DsfrSpacings.s1w,
        children: [
          DsfrRadioIcon(value: value, groupValue: groupValue, size: _getIconSize()),
          Flexible(
            child: DefaultTextStyle(
              style: DsfrTextStyle.bodyMd(color: DsfrColorDecisions.textLabelGrey(context)),
              child: child,
            ),
          ),
        ],
      ),
    ),
  );
}
