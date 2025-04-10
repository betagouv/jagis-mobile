import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class HomeActionGlobalCounter extends StatelessWidget {
  const HomeActionGlobalCounter({super.key, required this.nbActionsDone});

  final int nbActionsDone;

  @override
  Widget build(final BuildContext context) {
    final thousand = nbActionsDone ~/ 1000;
    final hundred = (nbActionsDone ~/ 100) % 10;
    final ten = (nbActionsDone ~/ 10) % 10;
    final unit = nbActionsDone % 10;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFF006854),
        border: const Border.fromBorderSide(BorderSide(color: Colors.white, width: 4)),
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(77), offset: const Offset(0, 10), blurRadius: 25)],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s1w),
        child: Row(
          children: [
            _Digit(thousand, milliseconds: 1500),
            _Digit(hundred, milliseconds: 1250),
            _Digit(ten, milliseconds: 1000),
            _Digit(unit, isLast: true),
          ],
        ),
      ),
    );
  }
}

class _Digit extends StatelessWidget {
  const _Digit(this.value, {this.isLast = false, this.milliseconds = 500});

  final int value;
  final bool isLast;
  final int milliseconds;

  @override
  Widget build(final BuildContext context) {
    final border = isLast
        ? const BoxDecoration()
        : const BoxDecoration(
            border: Border(right: BorderSide(color: Colors.white)),
          );

    return DecoratedBox(
      decoration: border,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s2w, horizontal: DsfrSpacings.s1w),
        child: AnimatedDigitWidget(
          textStyle: const DsfrTextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.white),
          value: value,
          duration: Duration(milliseconds: milliseconds),
          enableSeparator: true,
        ),
      ),
    );
  }
}
