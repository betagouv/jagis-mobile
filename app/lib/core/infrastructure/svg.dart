import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';
import 'package:vector_graphics_compiler/vector_graphics_compiler.dart';

class FnvSvg extends StatelessWidget {
  FnvSvg.asset(
    final String assetName, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.semanticsLabel,
  }) : source = AssetBytesLoader(assetName);

  FnvSvg.network(
    final String url, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.semanticsLabel,
  }) : source = _NetworkSvgLoader(url);

  final BytesLoader source;
  final BoxFit fit;
  final Alignment alignment;
  final double? width;
  final double? height;
  final String? semanticsLabel;

  @override
  Widget build(final BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: Semantics(
      label: semanticsLabel,
      child: VectorGraphic(
        loader: source,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        placeholderBuilder: (final context) => SizedBox(width: width, height: height),
      ),
    ),
  );
}

class _NetworkSvgLoader extends BytesLoader {
  const _NetworkSvgLoader(this.url);

  final String url;

  @override
  Future<ByteData> loadBytes(final BuildContext? context) => compute(
    (final svgUrl) async {
      final dio = Dio();
      final response = await dio.get<String>(svgUrl);
      dio.close();
      final task = TimelineTask()..start('encodeSvg');
      final compiledBytes = encodeSvg(
        xml: response.data!,
        debugName: svgUrl,
        enableMaskingOptimizer: false,
        enableClippingOptimizer: false,
        enableOverdrawOptimizer: false,
      );
      task.finish();

      return compiledBytes.buffer.asByteData();
    },
    url,
    debugLabel: 'Load Bytes',
  );

  @override
  int get hashCode => url.hashCode;

  @override
  bool operator ==(final Object other) => other is _NetworkSvgLoader && other.url == url;
}
