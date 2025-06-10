import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvBlockQuote extends StatelessWidget {
  const FnvBlockQuote({super.key, required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: const Color(0xFFFBFBFB),
      border: Border(
        left: BorderSide(color: color, width: DsfrSpacings.s1v),
      ),
      boxShadow: const [BoxShadow(color: Color(0x0D000068), offset: Offset(0, 5), blurRadius: 20)],
    ),
    child: Padding(padding: const EdgeInsets.only(left: 20, top: 16, right: 16, bottom: 24), child: child),
  );
}
