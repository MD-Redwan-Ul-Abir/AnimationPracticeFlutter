import 'package:flutter/material.dart';
import 'dart:math' as math;

// Enum for different animation path types
enum AnimationPathType {
  circular,
  elliptical,
  figureEight,
  linear,
  zigzag,
  spiral,
  wave,
  bounce,
}

// Class to define animation configuration for each element
class AnimationConfig {
  final AnimationPathType pathType;
  final Duration duration;
  final Curve curve;
  final Map<String, dynamic> parameters;
  final Alignment startPosition;
  final Alignment? endPosition;
  final Color? color;
  final double? size;
  final Widget? customWidget;

  AnimationConfig({
    required this.pathType,
    this.duration = const Duration(milliseconds: 2000),
    this.curve = Curves.easeInOut,
    this.parameters = const {},
    this.startPosition = Alignment.center,
    this.endPosition,
    this.color,
    this.size,
    this.customWidget,
  });
}

// Data class for animated elements
class AnimatedElement {
  final String id;
  final AnimationConfig config;
  final Widget? child;

  AnimatedElement({
    required this.id,
    required this.config,
    this.child,
  });
}

// Animation path generator class
class AnimationPathGenerator {
  // Factory method to create path-specific TweenSequences
  static TweenSequence<Alignment> createPathAnimation(
      AnimationPathType pathType,
      Map<String, dynamic> parameters,
      Alignment startPosition,
      Alignment? endPosition,
      ) {
    switch (pathType) {
      case AnimationPathType.circular:
        return _createCircularPath(parameters, startPosition);
      case AnimationPathType.elliptical:
        return _createEllipticalPath(parameters, startPosition);
      case AnimationPathType.figureEight:
        return _createFigureEightPath(parameters, startPosition);
      case AnimationPathType.linear:
        return _createLinearPath(startPosition, endPosition ?? Alignment.bottomCenter);
      case AnimationPathType.zigzag:
        return _createZigzagPath(parameters, startPosition, endPosition);
      case AnimationPathType.spiral:
        return _createSpiralPath(parameters, startPosition);
      case AnimationPathType.wave:
        return _createWavePath(parameters, startPosition, endPosition);
      case AnimationPathType.bounce:
        return _createBouncePath(parameters, startPosition, endPosition);
      default:
        return _createLinearPath(startPosition, endPosition ?? Alignment.center);
    }
  }

  // Circular path animation
  static TweenSequence<Alignment> _createCircularPath(
      Map<String, dynamic> parameters,
      Alignment startPosition,
      ) {
    final double radius = parameters['radius'] ?? 0.5;
    final double centerX = parameters['centerX'] ?? startPosition.x;
    final double centerY = parameters['centerY'] ?? startPosition.y;
    final int points = parameters['points'] ?? 30;
    final double startAngle = parameters['startAngle'] ?? -math.pi / 2;

    List<TweenSequenceItem<Alignment>> items = [];

    for (int i = 0; i < points; i++) {
      double currentTheta = startAngle + (i * 2 * math.pi / points);
      double nextTheta = startAngle + ((i + 1) * 2 * math.pi / points);

      Alignment begin = Alignment(
        centerX + radius * math.cos(currentTheta),
        centerY + radius * math.sin(currentTheta),
      );

      Alignment end = Alignment(
        centerX + radius * math.cos(nextTheta),
        centerY + radius * math.sin(nextTheta),
      );

      items.add(TweenSequenceItem(
        tween: AlignmentTween(begin: begin, end: end),
        weight: (1000 ~/ points).toDouble(),
      ));
    }

    return TweenSequence(items);
  }

  // Elliptical path animation
  static TweenSequence<Alignment> _createEllipticalPath(
      Map<String, dynamic> parameters,
      Alignment startPosition,
      ) {
    final double radiusX = parameters['radiusX'] ?? 0.5;
    final double radiusY = parameters['radiusY'] ?? 0.3;
    final double centerX = parameters['centerX'] ?? startPosition.x;
    final double centerY = parameters['centerY'] ?? startPosition.y;
    final int points = parameters['points'] ?? 30;
    final double startAngle = parameters['startAngle'] ?? -math.pi / 2;

    List<TweenSequenceItem<Alignment>> items = [];

    for (int i = 0; i < points; i++) {
      double currentTheta = startAngle + (i * 2 * math.pi / points);
      double nextTheta = startAngle + ((i + 1) * 2 * math.pi / points);

      Alignment begin = Alignment(
        centerX + radiusX * math.cos(currentTheta),
        centerY + radiusY * math.sin(currentTheta),
      );

      Alignment end = Alignment(
        centerX + radiusX * math.cos(nextTheta),
        centerY + radiusY * math.sin(nextTheta),
      );

      items.add(TweenSequenceItem(
        tween: AlignmentTween(begin: begin, end: end),
        weight: (1000 ~/ points).toDouble(),
      ));
    }

    return TweenSequence(items);
  }

  // Figure-8 path animation
  static TweenSequence<Alignment> _createFigureEightPath(
      Map<String, dynamic> parameters,
      Alignment startPosition,
      ) {
    final double radius = parameters['radius'] ?? 0.4;
    final int points = parameters['points'] ?? 60;
    final double centerX = parameters['centerX'] ?? startPosition.x;
    final double centerY = parameters['centerY'] ?? startPosition.y;

    List<TweenSequenceItem<Alignment>> items = [];

    for (int i = 0; i < points; i++) {
      double t = i / points;
      double nextT = (i + 1) / points;

      Alignment begin = Alignment(
        centerX + radius * math.sin(2 * math.pi * t),
        centerY + radius * math.sin(4 * math.pi * t) / 2,
      );

      Alignment end = Alignment(
        centerX + radius * math.sin(2 * math.pi * nextT),
        centerY + radius * math.sin(4 * math.pi * nextT) / 2,
      );

      items.add(TweenSequenceItem(
        tween: AlignmentTween(begin: begin, end: end),
        weight: (1000 ~/ points).toDouble(),
      ));
    }

    return TweenSequence(items);
  }

  // Linear path animation
  static TweenSequence<Alignment> _createLinearPath(
      Alignment start,
      Alignment end,
      ) {
    return TweenSequence([
      TweenSequenceItem(
        tween: AlignmentTween(begin: start, end: end),
        weight: 1000.0,
      ),
    ]);
  }

  // Zigzag path animation
  static TweenSequence<Alignment> _createZigzagPath(
      Map<String, dynamic> parameters,
      Alignment startPosition,
      Alignment? endPosition,
      ) {
    final int zigzags = parameters['zigzags'] ?? 3;
    final double amplitude = parameters['amplitude'] ?? 0.3;
    final Alignment finalPosition = endPosition ?? Alignment.bottomCenter;

    List<TweenSequenceItem<Alignment>> items = [];
    final int totalPoints = zigzags * 2 + 1;

    for (int i = 0; i < totalPoints; i++) {
      double progress = i / (totalPoints - 1);
      double nextProgress = (i + 1) / (totalPoints - 1);

      double currentX = startPosition.x + (finalPosition.x - startPosition.x) * progress;
      double nextX = startPosition.x + (finalPosition.x - startPosition.x) * nextProgress;

      double zigzagOffset = amplitude * math.sin(progress * zigzags * math.pi);
      double nextZigzagOffset = amplitude * math.sin(nextProgress * zigzags * math.pi);

      Alignment begin = Alignment(
        currentX + zigzagOffset,
        startPosition.y + (finalPosition.y - startPosition.y) * progress,
      );

      Alignment end = Alignment(
        nextX + nextZigzagOffset,
        startPosition.y + (finalPosition.y - startPosition.y) * nextProgress,
      );

      items.add(TweenSequenceItem(
        tween: AlignmentTween(begin: begin, end: end),
        weight: (1000 ~/ totalPoints).toDouble(),
      ));
    }

    return TweenSequence(items);
  }

  // Spiral path animation
  static TweenSequence<Alignment> _createSpiralPath(
      Map<String, dynamic> parameters,
      Alignment startPosition,
      ) {
    final double maxRadius = parameters['maxRadius'] ?? 0.8;
    final double turns = parameters['turns'] ?? 3.0;
    final int points = parameters['points'] ?? 60;

    List<TweenSequenceItem<Alignment>> items = [];

    for (int i = 0; i < points; i++) {
      double progress = i / (points - 1);
      double nextProgress = (i + 1) / (points - 1);

      double currentRadius = maxRadius * progress;
      double nextRadius = maxRadius * nextProgress;

      double currentAngle = progress * turns * 2 * math.pi;
      double nextAngle = nextProgress * turns * 2 * math.pi;

      Alignment begin = Alignment(
        startPosition.x + currentRadius * math.cos(currentAngle),
        startPosition.y + currentRadius * math.sin(currentAngle),
      );

      Alignment end = Alignment(
        startPosition.x + nextRadius * math.cos(nextAngle),
        startPosition.y + nextRadius * math.sin(nextAngle),
      );

      items.add(TweenSequenceItem(
        tween: AlignmentTween(begin: begin, end: end),
        weight: (1000 ~/ points).toDouble(),
      ));
    }

    return TweenSequence(items);
  }

  // Wave path animation
  static TweenSequence<Alignment> _createWavePath(
      Map<String, dynamic> parameters,
      Alignment startPosition,
      Alignment? endPosition,
      ) {
    final double frequency = parameters['frequency'] ?? 2.0;
    final double amplitude = parameters['amplitude'] ?? 0.3;
    final int points = parameters['points'] ?? 50;
    final Alignment finalPosition = endPosition ?? Alignment.bottomCenter;

    List<TweenSequenceItem<Alignment>> items = [];

    for (int i = 0; i < points; i++) {
      double progress = i / (points - 1);
      double nextProgress = (i + 1) / (points - 1);

      double waveOffset = amplitude * math.sin(progress * frequency * 2 * math.pi);
      double nextWaveOffset = amplitude * math.sin(nextProgress * frequency * 2 * math.pi);

      Alignment begin = Alignment(
        startPosition.x + (finalPosition.x - startPosition.x) * progress + waveOffset,
        startPosition.y + (finalPosition.y - startPosition.y) * progress,
      );

      Alignment end = Alignment(
        startPosition.x + (finalPosition.x - startPosition.x) * nextProgress + nextWaveOffset,
        startPosition.y + (finalPosition.y - startPosition.y) * nextProgress,
      );

      items.add(TweenSequenceItem(
        tween: AlignmentTween(begin: begin, end: end),
        weight: (1000 ~/ points).toDouble(),
      ));
    }

    return TweenSequence(items);
  }

  // Bounce path animation
  static TweenSequence<Alignment> _createBouncePath(
      Map<String, dynamic> parameters,
      Alignment startPosition,
      Alignment? endPosition,
      ) {
    final int bounces = parameters['bounces'] ?? 3;
    final double bounceHeight = parameters['bounceHeight'] ?? 0.3;
    final Alignment finalPosition = endPosition ?? Alignment.bottomCenter;

    List<TweenSequenceItem<Alignment>> items = [];
    final int totalPoints = bounces * 2 + 1;

    for (int i = 0; i < totalPoints; i++) {
      double progress = i / (totalPoints - 1);
      double nextProgress = (i + 1) / (totalPoints - 1);

      double bounceY = bounceHeight * math.sin(progress * bounces * math.pi).abs();
      double nextBounceY = bounceHeight * math.sin(nextProgress * bounces * math.pi).abs();

      Alignment begin = Alignment(
        startPosition.x + (finalPosition.x - startPosition.x) * progress,
        startPosition.y + (finalPosition.y - startPosition.y) * progress - bounceY,
      );

      Alignment end = Alignment(
        startPosition.x + (finalPosition.x - startPosition.x) * nextProgress,
        startPosition.y + (finalPosition.y - startPosition.y) * nextProgress - nextBounceY,
      );

      items.add(TweenSequenceItem(
        tween: AlignmentTween(begin: begin, end: end),
        weight: (1000 ~/ totalPoints).toDouble(),
      ));
    }

    return TweenSequence(items);
  }
}

// Main animation controller class
class SplashAnimationController {
  final List<AnimatedElement> elements;
  final VoidCallback? onAnimationComplete;

  SplashAnimationController({
    required this.elements,
    this.onAnimationComplete,
  });
}

// Main widget for animated splash screen
class AnimatedSplashScreen extends StatefulWidget {
  final SplashAnimationController controller;
  final Widget? backgroundWidget;
  final Color? backgroundColor;

  const AnimatedSplashScreen({
    super.key,
    required this.controller,
    this.backgroundWidget,
    this.backgroundColor,
  });

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with TickerProviderStateMixin {
  late Map<String, AnimationController> animationControllers;
  late Map<String, Animation<Alignment>> animations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    animationControllers = {};
    animations = {};

    for (final element in widget.controller.elements) {
      // Create individual animation controller for each element
      final controller = AnimationController(
        vsync: this,
        duration: element.config.duration,
      );

      // Create path animation
      final tweenSequence = AnimationPathGenerator.createPathAnimation(
        element.config.pathType,
        element.config.parameters,
        element.config.startPosition,
        element.config.endPosition,
      );

      // Create animation with curve
      final animation = controller.drive(
          tweenSequence.chain(CurveTween(curve: element.config.curve))
      );

      animationControllers[element.id] = controller;
      animations[element.id] = animation;
    }
  }

  void _startAnimations() {
    for (final controller in animationControllers.values) {
      controller.repeat();
    }

    // Optional: Call completion callback after longest animation
    if (widget.controller.onAnimationComplete != null) {
      final longestDuration = widget.controller.elements
          .map((e) => e.config.duration.inMilliseconds)
          .reduce(math.max);

      Future.delayed(Duration(milliseconds: longestDuration), () {
        if (mounted) {
          widget.controller.onAnimationComplete!();
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in animationControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildAnimatedElement(AnimatedElement element) {
    final animation = animations[element.id]!;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Align(
          alignment: animation.value,
          child: element.child ??
              element.config.customWidget ??
              Container(
                height: element.config.size ?? 20,
                width: element.config.size ?? 20,
                decoration: BoxDecoration(
                  color: element.config.color ?? Colors.pink,
                  shape: BoxShape.circle,
                ),
              ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Stack(
        children: [
          // Background widget if provided
          if (widget.backgroundWidget != null)
            Positioned.fill(child: widget.backgroundWidget!),

          // Animated elements
          ...widget.controller.elements.map(_buildAnimatedElement),
        ],
      ),
    );
  }
}