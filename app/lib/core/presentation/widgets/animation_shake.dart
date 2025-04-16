import 'package:flutter/material.dart';

class AnimationShake extends StatefulWidget {
  const AnimationShake({super.key, required this.child});

  final Widget child;

  @override
  State<AnimationShake> createState() => _AnimationShakeState();
}

/// Passer des radians aux degrés (PI/180).
const _degreesFromRadians = 0.017453292519943295;

class _AnimationShakeState extends State<AnimationShake> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    const zero = 0.0;
    const maxAngle = 2.0;
    final tweenSequence = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: zero, end: zero), weight: 10),
      TweenSequenceItem(tween: Tween(begin: zero, end: maxAngle), weight: 10),
      TweenSequenceItem(tween: Tween(begin: maxAngle, end: -maxAngle), weight: 10),
      TweenSequenceItem(tween: Tween(begin: -maxAngle, end: maxAngle), weight: 10),
      TweenSequenceItem(tween: Tween(begin: maxAngle, end: -maxAngle), weight: 10),
      TweenSequenceItem(tween: Tween(begin: -maxAngle, end: zero), weight: 10),
      TweenSequenceItem(tween: Tween(begin: zero, end: zero), weight: 40),
    ]);

    _controller = AnimationController(duration: const Duration(seconds: 3), vsync: this)..repeat();
    _animation = tweenSequence.animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => AnimatedBuilder(
    animation: _animation,
    builder:
        (final context, final child) =>
            Transform.rotate(angle: _animation.value * _degreesFromRadians, alignment: Alignment.bottomCenter, child: child),
    child: widget.child,
  );
}
