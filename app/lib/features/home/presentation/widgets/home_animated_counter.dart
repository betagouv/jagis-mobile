import 'package:animated_digit/animated_digit.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class HomeAnimatedCounter extends StatefulWidget {
  const HomeAnimatedCounter({super.key, required this.nbActionsDone});

  final int nbActionsDone;

  @override
  State<HomeAnimatedCounter> createState() => _HomeAnimatedCounterState(nbActionsDone);
}

class _HomeAnimatedCounterState extends State<HomeAnimatedCounter> {
  _HomeAnimatedCounterState(this.nbActionsDone);

  late int nbActionsDone;
  final _controller = AnimatedDigitController(0);

  @override
  void initState() {
    super.initState();
    _controller.addValue(nbActionsDone);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final thousand = nbActionsDone ~/ 1000;
    final hundred = (nbActionsDone ~/ 100) % 10;
    final ten = (nbActionsDone ~/ 10) % 10;
    final unit = nbActionsDone % 10;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white, width: 4),
        color: const Color(0xFF006854),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 25, offset: const Offset(0, 10))],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s1w),
        child: Row(
          children: [
            _Digit(thousand, milliseconds: 1500),
            _Digit(hundred, milliseconds: 1250),
            _Digit(ten, milliseconds: 1000),
            _Digit(unit, isLast: true, milliseconds: 500),
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
    final border = isLast ? const BoxDecoration() : const BoxDecoration(border: Border(right: BorderSide(color: Colors.white)));

    return DecoratedBox(
      decoration: border,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s2w, horizontal: DsfrSpacings.s1w),
        child: AnimatedDigitWidget(
          value: value,
          duration: Duration(milliseconds: milliseconds),
          textStyle: const DsfrTextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.white),
          enableSeparator: true,
        ),
      ),
    );
  }
}
