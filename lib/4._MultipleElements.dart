import 'dart:math' as Math;

import 'package:flutter/material.dart';

class MultipleAnimationExample extends StatefulWidget {
  const MultipleAnimationExample({super.key});

  @override
  State<MultipleAnimationExample> createState() => _MultipleAnimationExampleState();
}

class _MultipleAnimationExampleState extends State<MultipleAnimationExample>
    with TickerProviderStateMixin {

  // Multiple animation controllers
  late AnimationController controller1;
  late AnimationController controller2;
  late AnimationController controller3;

  // Different alignment tweens for different paths
  AlignmentTween path1 = AlignmentTween(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight
  );

  AlignmentTween path2 = AlignmentTween(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft
  );

  AlignmentTween path3 = AlignmentTween(
      begin: Alignment.center,
      end: Alignment.topCenter
  );

  // Animations
  late Animation<Alignment> animation1;
  late Animation<Alignment> animation2;
  late Animation<Alignment> animation3;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with different durations
    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    controller3 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Initialize animations with different curves
    animation1 = controller1.drive(
        path1.chain(CurveTween(curve: Curves.easeInOutBack))
    );

    animation2 = controller2.drive(
        path2.chain(CurveTween(curve: Curves.bounceOut))
    );

    animation3 = controller3.drive(
        path3.chain(CurveTween(curve: Curves.elasticOut))
    );
  }

  @override
  void dispose() {
    // Dispose all controllers
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  void startAllAnimations() {
    controller1.reset();
    controller2.reset();
    controller3.reset();

    controller1.forward();
    controller2.forward();
    controller3.forward();
  }

  void startAnimation(int index) {
    switch (index) {
      case 1:
        controller1.reset();
        controller1.forward();
        break;
      case 2:
        controller2.reset();
        controller2.forward();
        break;
      case 3:
        controller3.reset();
        controller3.forward();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multiple Container Animations"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Container 1 - Pink
          AnimatedBuilder(
            animation: animation1,
            builder: (context, child) {
              return Align(
                alignment: animation1.value,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),

          // Container 2 - Blue
          AnimatedBuilder(
            animation: animation2,
            builder: (context, child) {
              return Align(
                alignment: animation2.value,
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            },
          ),

          // Container 3 - Green
          AnimatedBuilder(
            animation: animation3,
            builder: (context, child) {
              return Align(
                alignment: animation3.value,
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.rectangle,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: "btn1",
            onPressed: () => startAnimation(1),
            child: const Text("1"),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.small(
            heroTag: "btn2",
            onPressed: () => startAnimation(2),
            child: const Text("2"),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.small(
            heroTag: "btn3",
            onPressed: () => startAnimation(3),
            child: const Text("3"),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "btnAll",
            onPressed: startAllAnimations,
            child: const Icon(Icons.play_circle),
          ),
        ],
      ),
    );
  }
}

// Custom Path Animation Example
class CustomPathAnimation extends StatefulWidget {
  const CustomPathAnimation({super.key});

  @override
  State<CustomPathAnimation> createState() => _CustomPathAnimationState();
}

class _CustomPathAnimationState extends State<CustomPathAnimation>
    with TickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // Custom path calculation
  Offset getPositionOnPath(double t, Size size) {
    // Example: Figure-8 path
    double x = size.width * 0.5 + 100 * Math.sin(2 * Math.pi * t);
    double y = size.height * 0.5 + 50 * Math.sin(4 * Math.pi * t);
    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Path Animation"),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final position = getPositionOnPath(
                animation.value,
                Size(constraints.maxWidth, constraints.maxHeight),
              );

              return Stack(
                children: [
                  Positioned(
                    left: position.dx - 15,
                    top: position.dy - 15,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.isAnimating) {
            controller.stop();
          } else if (controller.isCompleted) {
            controller.reset();
            controller.forward();
          } else {
            controller.forward();
          }
        },
        child: Icon(
          controller.isAnimating
              ? Icons.pause
              : Icons.play_arrow,
        ),
      ),
    );
  }
}