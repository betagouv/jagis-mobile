import 'package:flutter/widgets.dart';

double screenWidth(final BuildContext context, final double? pct) =>
    pct == null ? MediaQuery.of(context).size.width : pct * MediaQuery.of(context).size.width;
