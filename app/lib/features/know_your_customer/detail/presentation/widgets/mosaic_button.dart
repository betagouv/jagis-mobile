import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class _MosaicButtonStyle {
  const _MosaicButtonStyle._({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.textStyle,
  });

  const _MosaicButtonStyle.selected()
    : this._(
        backgroundColor: const Color(0xfff3f3f8),
        borderColor: DsfrColors.blueFranceSun113,
        borderWidth: 1,
        textStyle: const DsfrTextStyle.bodyMdBold(color: DsfrColors.blueFranceSun113),
      );

  const _MosaicButtonStyle.unselected()
    : this._(
        backgroundColor: const Color(0xfff8f8f7),
        borderColor: const Color(0xffe3e3db),
        borderWidth: 1,
        textStyle: const DsfrTextStyle.bodyMd(color: DsfrColors.grey50),
      );

  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final DsfrTextStyle textStyle;
}

abstract final class _MosaicButtonStyles {
  static const selected = _MosaicButtonStyle.selected();
  static const unselected = _MosaicButtonStyle.unselected();
}

class MosaicButton extends StatelessWidget {
  const MosaicButton({super.key, required this.emoji, required this.title, required this.value, required this.onChanged});

  final String? emoji;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(final BuildContext context) {
    final style = value ? _MosaicButtonStyles.selected : _MosaicButtonStyles.unselected;

    return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: style.backgroundColor,
            border: Border.all(color: style.borderColor, width: style.borderWidth),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Material(
              color: FnvColors.transparent,
              child: InkWell(
                onTap: () => onChanged(!value),
                child: Padding(
                  padding: const EdgeInsets.all(DsfrSpacings.s1w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: DsfrSpacings.s1v,
                    children: [
                      Text(emoji ?? '', style: const TextStyle(fontSize: 40)),
                      Text(title, style: style.textStyle, textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(top: 14, right: 14, child: DsfrCheckboxIcon(value: value)),
      ],
    );
  }
}
