import 'package:flutter/widgets.dart';

/// Returns the screen width based on the given percentage of the screen width.
double screenWidth(final BuildContext context, {final double percentage = 1}) => percentage * MediaQuery.sizeOf(context).width;
