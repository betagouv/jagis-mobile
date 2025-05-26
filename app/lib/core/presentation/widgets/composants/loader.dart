import 'package:flutter/material.dart';

class FnvLoader extends StatefulWidget {
  const FnvLoader({super.key});

  @override
  State<FnvLoader> createState() => _FnvLoaderState();
}

class _FnvLoaderState extends State<FnvLoader> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 1), vsync: this)..repeat(reverse: true);

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-0.5, 0),
      end: const Offset(0.5, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _colorAnimation = TweenSequence<Color?>(_getSequenceColor(const [Color(0xFF00A081), Color(0xFFDDB7E6)])).animate(_controller);
  }

  List<TweenSequenceItem<Color?>> _getSequenceColor(final List<Color> colors) {
    final weight = 100 / (colors.length - 1);

    return List.generate(
      colors.length - 1,
      (final i) => TweenSequenceItem<Color?>(
        tween: ColorTween(begin: colors[i], end: colors[i + 1]),
        weight: weight,
      ),
      growable: false,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    const amplitude = 75.0;
    const ballWidth = 40.0;

    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (final context, final child) => Transform.translate(
          offset: Offset(_offsetAnimation.value.dx * amplitude, 0),
          child: SizedBox.square(
            dimension: ballWidth,
            child: DecoratedBox(
              decoration: BoxDecoration(color: _colorAnimation.value, shape: BoxShape.circle),
            ),
          ),
        ),
      ),
    );
  }
}
