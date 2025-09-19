// import 'dart:math' as math;
//
// import 'package:flutter/material.dart';
//
// class ElementMovingWithMultidirection extends StatefulWidget {
//   const ElementMovingWithMultidirection({super.key});
//
//   @override
//   State<ElementMovingWithMultidirection> createState() => _ElementMovingWithMultidirectionState();
// }
//
// class _ElementMovingWithMultidirectionState extends State<ElementMovingWithMultidirection> with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   late Animation<double> animation;
//
//   // Parameters for circular motion
//   final double radius = 0.5; // Circle radius
//   final double centerX = 0.0; // Center X position
//   final double centerY = 0.0; // Center Y position
//   final int points = 8; // Number of points in the circle
//
//   // Method to generate TweenSequence using theta values
//   TweenSequence<Alignment> createCircularTweenSequence({
//     double radius = 0.5,
//     double centerX = 0.0,
//     double centerY = 0.0,
//     int points = 8,
//     double startAngle = -math.pi / 2, // Start from top (-90 degrees)
//   }) {
//     List<TweenSequenceItem<Alignment>> items = [];
//
//     for (int i = 0; i < points; i++) {
//       // Calculate current and next theta values
//       double currentTheta = startAngle + (i * 2 * math.pi / points);
//       double nextTheta = startAngle + ((i + 1) * 2 * math.pi / points);
//
//       // Convert polar coordinates to Cartesian (Alignment values)
//       Alignment begin = Alignment(
//         centerX + radius * math.cos(currentTheta),
//         centerY + radius * math.sin(currentTheta),
//       );
//
//       Alignment end = Alignment(
//         centerX + radius * math.cos(nextTheta),
//         centerY + radius * math.sin(nextTheta),
//       );
//
//       items.add(TweenSequenceItem(
//         tween: AlignmentTween(begin: begin, end: end),
//         weight: (1000 ~/ points).toDouble(), // Equal weight distribution
//       ));
//     }
//
//     return TweenSequence(items);
//   }
//
//   // Alternative method: Create elliptical motion
//   TweenSequence<Alignment> createEllipticalTweenSequence({
//     double radiusX = 0.5,
//     double radiusY = 0.3,
//     double centerX = 0.0,
//     double centerY = 0.0,
//     int points = 8,
//     double startAngle = -math.pi / 2,
//   }) {
//     List<TweenSequenceItem<Alignment>> items = [];
//
//     for (int i = 0; i < points; i++) {
//       double currentTheta = startAngle + (i * 2 * math.pi / points);
//       double nextTheta = startAngle + ((i + 1) * 2 * math.pi / points);
//
//       Alignment begin = Alignment(
//         centerX + radiusX * math.cos(currentTheta),
//         centerY + radiusY * math.sin(currentTheta),
//       );
//
//       Alignment end = Alignment(
//         centerX + radiusX * math.cos(nextTheta),
//         centerY + radiusY * math.sin(nextTheta),
//       );
//
//       items.add(TweenSequenceItem(
//         tween: AlignmentTween(begin: begin, end: end),
//         weight: (1000 ~/ points).toDouble(),
//       ));
//     }
//
//     return TweenSequence(items);
//   }
//
//   // Method to create figure-8 pattern
//   TweenSequence<Alignment> createFigureEightTweenSequence({
//     double radius = 0.4,
//     int points = 16,
//   }) {
//     List<TweenSequenceItem<Alignment>> items = [];
//
//     for (int i = 0; i < points; i++) {
//       double t = i / points;
//       double nextT = (i + 1) / points;
//
//       // Figure-8 parametric equations
//       Alignment begin = Alignment(
//         radius * math.sin(2 * math.pi * t),
//         radius * math.sin(4 * math.pi * t) / 2,
//       );
//
//       Alignment end = Alignment(
//         radius * math.sin(2 * math.pi * nextT),
//         radius * math.sin(4 * math.pi * nextT) / 2,
//       );
//
//       items.add(TweenSequenceItem(
//         tween: AlignmentTween(begin: begin, end: end),
//         weight: (1000 ~/ points).toDouble(),
//       ));
//     }
//
//     return TweenSequence(items);
//   }
//   TweenSequence<Alignment> tweenSequence1 = TweenSequence([
//     // 8-point circular motion for smoother curve
//     TweenSequenceItem(
//         tween: AlignmentTween(begin: Alignment(0, -0.5), end: Alignment(0.35, -0.35)),
//         weight: 125
//     ),
//     TweenSequenceItem(
//         tween: AlignmentTween(begin: Alignment(0.35, -0.35), end: Alignment(0.5, 0)),
//         weight: 125
//     ),
//     TweenSequenceItem(
//         tween: AlignmentTween(begin: Alignment(0.5, 0), end: Alignment(0.35, 0.35)),
//         weight: 125
//     ),
//     TweenSequenceItem(
//         tween: AlignmentTween(begin: Alignment(0.35, 0.35), end: Alignment(0, 0.5)),
//         weight: 125
//     ),
//     TweenSequenceItem(
//         tween: AlignmentTween(begin: Alignment(0, 0.5), end: Alignment(-0.35, 0.35)),
//         weight: 125
//     ),
//     TweenSequenceItem(
//         tween: AlignmentTween(begin: Alignment(-0.35, 0.35), end: Alignment(-0.5, 0)),
//         weight: 125
//     ),
//     TweenSequenceItem(
//         tween: AlignmentTween(begin: Alignment(-0.5, 0), end: Alignment(-0.35, -0.35)),
//         weight: 125
//     ),
//     TweenSequenceItem(
//         tween: AlignmentTween(begin: Alignment(-0.35, -0.35), end: Alignment(0, -0.5)),
//         weight: 125
//     ),
//   ]);
//
//   @override
//   void initState() {
//     super.initState();
//     // animationController = AnimationController(
//     //   vsync: this,
//     //   duration: Duration(milliseconds: 1000),
//     // );
//     //
//     // // Initialize the animation in initState
//     // // Using easeInOut instead of easeInOutBack to avoid overshoot issues
//     // // animation = animationController.drive(
//     // //     tweenSequence1.chain(CurveTween(curve: Curves.easeInOut))
//     //
//     //
//     // );
//     animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 2000),
//     );
//
//     // Use the mathematical approach instead of hardcoded values
//     TweenSequence<Alignment> tweenSequence = createCircularTweenSequence(
//       radius: 0.5,
//       centerX: 0.0,
//       centerY: 0.0,
//       points: 8,
//       startAngle: -math.pi / 2, // Start from top
//     );
//
//     animation = animationController.drive(
//         tweenSequence.chain(CurveTween(curve: Curves.easeInOut))
//     );
//   }
//
//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("3.0 Element moving animation curve"),
//         centerTitle: true,
//       ),
//       body: AnimatedBuilder(
//         // Listen to the animation, not the controller
//           animation: animation,
//           builder: (context, child) {
//             return Align(
//               alignment: animation.value,
//               child: Container(height: 20, width: 20, color: Colors.pink),
//             );
//           }
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           animationController.reset();
//           print("current value =====>> ${animationController.value}");
//           animationController.forward();
//         },
//         child: Center(child: Icon(Icons.play_circle)),
//       ),
//     );
//   }
// }




///=================================----------------======================================
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ElementMovingWithMultidirection extends StatefulWidget {
  const ElementMovingWithMultidirection({super.key});

  @override
  State<ElementMovingWithMultidirection> createState() => _ElementMovingWithMultidirectionState();
}

class _ElementMovingWithMultidirectionState extends State<ElementMovingWithMultidirection> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Alignment> animation; // Changed from Animation<double> to Animation<Alignment>

  // Parameters for circular motion
  final double radius = 0.5; // Circle radius
  final double centerX = 0.0; // Center X position
  final double centerY = 0.0; // Center Y position
  final int points = 30; // Number of points in the circle

  // Method to generate TweenSequence using theta values
  TweenSequence<Alignment> createCircularTweenSequence({
    double radius = 0.5,
    double centerX = 0.0,
    double centerY = 0.0,
    int points = 30,
    double startAngle = -math.pi / 2, // Start from top (-90 degrees)
  }) {
    List<TweenSequenceItem<Alignment>> items = [];

    for (int i = 0; i < points; i++) {
      // Calculate current and next theta values
      double currentTheta = startAngle + (i * 2 * math.pi / points);
      double nextTheta = startAngle + ((i + 1) * 2 * math.pi / points);

      // Convert polar coordinates to Cartesian (Alignment values)
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
        weight: (1000 ~/ points).toDouble(), // Equal weight distribution
      ));
    }

    return TweenSequence(items);
  }

  // Alternative method: Create elliptical motion
  TweenSequence<Alignment> createEllipticalTweenSequence({
    double radiusX = 0.5,
    double radiusY = 0.3,
    double centerX = 0.0,
    double centerY = 0.0,
    int points = 30,
    double startAngle = -math.pi / 2,
  }) {
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

  // Method to create figure-8 pattern
  TweenSequence<Alignment> createFigureEightTweenSequence({
    double radius = 0.4,
    int points = 60,
  }) {
    List<TweenSequenceItem<Alignment>> items = [];

    for (int i = 0; i < points; i++) {
      double t = i / points;
      double nextT = (i + 1) / points;

      // Figure-8 parametric equations
      Alignment begin = Alignment(
        radius * math.sin(2 * math.pi * t),
        radius * math.sin(4 * math.pi * t) / 2,
      );

      Alignment end = Alignment(
        radius * math.sin(2 * math.pi * nextT),
        radius * math.sin(4 * math.pi * nextT) / 2,
      );

      items.add(TweenSequenceItem(
        tween: AlignmentTween(begin: begin, end: end),
        weight: (1000 ~/ points).toDouble(),
      ));
    }

    return TweenSequence(items);
  }

  // Helper method to update animation
  void _updateAnimation(TweenSequence<Alignment> tweenSequence) {
    setState(() {
      animation = animationController.drive(
          tweenSequence.chain(CurveTween(curve: Curves.easeIn))
      );
    });
    animationController.reset();
    animationController.repeat(); // Changed to repeat for continuous animation
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    // Use the mathematical approach instead of hardcoded values
    TweenSequence<Alignment> tweenSequence = createCircularTweenSequence(
      radius: 0.5,
      centerX: 0.0,
      centerY: 0.0,
      points: 30,
      startAngle: -math.pi / 2, // Start from top
    );

    animation = animationController.drive(
        tweenSequence.chain(CurveTween(curve: Curves.easeIn))
    );

    // Start the animation
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mathematical Circular Motion"),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Align(
              alignment: animation.value,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "circular",
            onPressed: () {
              // Switch to circular motion
              TweenSequence<Alignment> tweenSequence = createCircularTweenSequence(
                radius: 0.5,
                points: 30,
              );
              _updateAnimation(tweenSequence);
            },
            child: Icon(Icons.radio_button_unchecked),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "elliptical",
            onPressed: () {
              // Switch to elliptical motion
              TweenSequence<Alignment> tweenSequence = createEllipticalTweenSequence(
                radiusX: 0.6,
                radiusY: 0.3,
                points: 12,
              );
              _updateAnimation(tweenSequence);
            },
            child: Icon(Icons.more_horiz),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "figure8",
            onPressed: () {
              // Switch to figure-8 motion
              TweenSequence<Alignment> tweenSequence = createFigureEightTweenSequence(
                radius: 0.4,
                points: 16,
              );
              _updateAnimation(tweenSequence);
            },
            child: Icon(Icons.all_inclusive),
          ),
        ],
      ),
    );
  }
}