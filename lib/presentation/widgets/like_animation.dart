import 'package:flutter/cupertino.dart';

const childSize = 12.0;

///
/// A widget that animates a like icon.
///
class LikeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool isAnimating;

  const LikeAnimation({
    super.key,
    this.child = const Icon(CupertinoIcons.heart_fill, size: childSize),
    this.duration = const Duration(seconds: 1),
    required this.isAnimating,
    this.onEnd,
  });

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

///
/// The state of the [LikeAnimation] widget.
///
/// It handles the animation of the like icon.
///
class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration * 0.15,
    );
    _sizeAnimation = Tween<double>(
      begin: childSize,
      end: childSize * 1.2,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isAnimating != widget.isAnimating) {
      animateLike();
    }
  }

  void animateLike() async {
    if (widget.isAnimating) {
      await _controller.forward();
      await _controller.reverse();
      await Future.delayed(widget.duration);
      widget.onEnd?.call();
      _controller.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isAnimating ? 1 : 0,
      duration: Duration(milliseconds: 200),
      child: ScaleTransition(
        scale: _sizeAnimation,
        child: widget.child,
      ),
    );
  }
}
