import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

Future<void> enlargeImage(final BuildContext context, {required final String src, required final String? semanticLabel}) =>
    showImageViewer(
      context,
      Image.network(src, semanticLabel: semanticLabel).image,
      immersive: false,
      useSafeArea: true,
      swipeDismissible: true,
      doubleTapZoomable: true,
      backgroundColor: FnvColors.background,
      closeButtonTooltip: 'Fermer',
      closeButtonColor: Colors.black,
    );
