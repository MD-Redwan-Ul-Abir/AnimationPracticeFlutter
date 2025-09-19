import 'package:flutter/material.dart';
import 'dart:math' as math;

class TwineAnimationExample extends StatefulWidget {
  const TwineAnimationExample({super.key});

  @override
  State<TwineAnimationExample> createState() => _TwineAnimationExampleState();
}

class _TwineAnimationExampleState extends State<TwineAnimationExample> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  // 24 elements in 3 layers (8 each)
  List<ElementData> elements = [];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );

    _initializeElements();
  }

  void _initializeElements() {
    elements.clear();

    final random = math.Random();

    // Generate random corner/edge position
    Alignment getRandomCornerPosition() {
      // All possible edge/corner positions
      List<Alignment> cornerPositions = [
        Alignment(-0.9, -0.9),   // Top Left
        Alignment(0.0, -0.9),    // Top Center
        Alignment(0.9, -0.9),    // Top Right
        Alignment(-0.9, 0.0),    // Center Left
        Alignment(0.9, 0.0),     // Center Right
        Alignment(-0.9, 0.9),    // Bottom Left
        Alignment(0.0, 0.9),     // Bottom Center
        Alignment(0.9, 0.9),     // Bottom Right
      ];

      // Pick a random corner/edge position
      Alignment basePos = cornerPositions[random.nextInt(cornerPositions.length)];

      // Add small random variation to make positions unique
      double variance = 0.15;
      double x = basePos.x + (random.nextDouble() - 0.5) * variance;
      double y = basePos.y + (random.nextDouble() - 0.5) * variance;

      // Keep values in valid range but maintain edge positioning
      if (basePos.x != 0) {
        x = x.clamp(basePos.x > 0 ? 0.7 : -1.0, basePos.x > 0 ? 1.0 : -0.7);
      }
      if (basePos.y != 0) {
        y = y.clamp(basePos.y > 0 ? 0.7 : -1.0, basePos.y > 0 ? 1.0 : -0.7);
      }

      return Alignment(x, y);
    }

    // Layer 1 - Fixed positions at edges (elements 1-8)
    List<Alignment> layer1Positions = [
      Alignment(-0.9, -0.9),   // Top Left
      Alignment(0.0, -0.9),    // Top Center
      Alignment(0.9, -0.9),    // Top Right
      Alignment(-0.9, 0.0),    // Center Left
      Alignment(0.9, 0.0),     // Center Right
      Alignment(-0.9, 0.9),    // Bottom Left
      Alignment(0.0, 0.9),     // Bottom Center
      Alignment(0.9, 0.9),     // Bottom Right
    ];

    // Layer 2 - Random positions spread across all corners (elements 9-16)
    List<Alignment> layer2Positions = [];
    for (int i = 0; i < 8; i++) {
      layer2Positions.add(getRandomCornerPosition());
    }

    // Layer 3 - Random positions spread across all corners (elements 17-24)
    List<Alignment> layer3Positions = [];
    for (int i = 0; i < 8; i++) {
      layer3Positions.add(getRandomCornerPosition());
    }

    List<Color> colors = [
      Colors.red, Colors.pink, Colors.purple, Colors.deepPurple,
      Colors.indigo, Colors.blue, Colors.lightBlue, Colors.cyan,
      Colors.teal, Colors.green, Colors.lightGreen, Colors.lime,
      Colors.yellow, Colors.amber, Colors.orange, Colors.deepOrange,
      Colors.brown, Colors.grey, Colors.blueGrey, Colors.black87,
      Colors.redAccent, Colors.purpleAccent, Colors.blueAccent, Colors.greenAccent,
    ];

    // Create elements for all 3 layers
    for (int i = 0; i < 8; i++) {
      elements.add(ElementData(
        id: i + 1,
        startPosition: layer1Positions[i],
        color: colors[i],
        layer: 1,
        startDelay: 0.0,
      ));
    }

    for (int i = 0; i < 8; i++) {
      elements.add(ElementData(
        id: i + 9,
        startPosition: layer2Positions[i],
        color: colors[i + 8],
        layer: 2,
        startDelay: 0.33, // Start when layer 1 reaches 1/3 distance
      ));
    }

    for (int i = 0; i < 8; i++) {
      elements.add(ElementData(
        id: i + 17,
        startPosition: layer3Positions[i],
        color: colors[i + 16],
        layer: 3,
        startDelay: 0.66, // Start when layer 1 reaches 2/3 distance
      ));
    }
  }

  void startAnimation() async {
    animationController.reset();
    await animationController.forward();
    // Add delay before reversing (adjust duration as needed)
    //await Future.delayed(Duration(milliseconds: 500));
    await animationController.reverse();

  }


  // Calculate stretching based on direction to center
  Map<String, double> _getStretch(ElementData element, double progress) {
    // Only stretch if this element has started moving
    if (progress < element.startDelay) return {'scaleX': 1.0, 'scaleY': 1.0};

    double adjustedProgress = ((progress - element.startDelay) / (1.0 - element.startDelay)).clamp(0.0, 1.0);
    if (adjustedProgress <= 0) return {'scaleX': 1.0, 'scaleY': 1.0};

    double dx = element.startPosition.x;
    double dy = element.startPosition.y;
    double distance = math.sqrt(dx * dx + dy * dy);

    // Create stretching curve - stretch more at beginning, return to normal at end
    double stretchCurve = math.sin(adjustedProgress * math.pi);

    // Calculate stretch factor based on distance (farther elements stretch more)
    double maxStretch = 1.0 + (distance * 1.5);
    double currentStretch = 1.0 + (maxStretch - 1.0) * stretchCurve;

    // Calculate stretch direction (towards center)
    double scaleX = 1.0;
    double scaleY = 1.0;

    if (dx.abs() < 0.01) {
      // Element is on vertical axis (top center or bottom center)
      scaleY = currentStretch;
      scaleX = 1.0 / math.sqrt(currentStretch); // Compensate to maintain volume
    } else if (dy.abs() < 0.01) {
      // Element is on horizontal axis (center left or center right)
      scaleX = currentStretch;
      scaleY = 1.0 / math.sqrt(currentStretch); // Compensate to maintain volume
    } else {
      // Element is diagonal - stretch along the line to center
      double ratio = dx.abs() / dy.abs();
      if (ratio > 1) {
        scaleX = currentStretch;
        scaleY = 1.0 + (currentStretch - 1.0) / ratio;
      } else {
        scaleY = currentStretch;
        scaleX = 1.0 + (currentStretch - 1.0) * ratio;
      }
    }

    return {'scaleX': scaleX, 'scaleY': scaleY};
  }

  // Calculate current position with easing
  Alignment _getCurrentPosition(ElementData element, double progress) {
    // Don't move until this element's start delay
    if (progress < element.startDelay) return element.startPosition;

    double adjustedProgress = ((progress - element.startDelay) / (1.0 - element.startDelay)).clamp(0.0, 1.0);

    // Use ease-out curve for realistic deceleration
    double easedProgress = 1 - math.pow(1 - adjustedProgress, 3).toDouble();

    return Alignment.lerp(element.startPosition, Alignment.center, easedProgress)!;
  }

  // Calculate opacity for visibility timing
  double _getOpacity(ElementData element, double progress) {
    // Elements are completely invisible until their start delay
    if (progress < element.startDelay) return 0.0;

    // Quick fade in when the element becomes visible
    double fadeProgress = (progress - element.startDelay) * 20; // Fast fade in
    return fadeProgress.clamp(0.0, 1.0);
  }

  // Calculate rotation to align stretch with direction to center
  double _getRotation(ElementData element) {
    double dx = element.startPosition.x;
    double dy = element.startPosition.y;

    // No rotation needed for elements on axes
    if (dx.abs() < 0.01 || dy.abs() < 0.01) {
      return 0.0;
    }

    // Calculate angle from element to center
    return math.atan2(-dy, -dx) - math.pi / 2;
  }

  // Helper function to get Layer 1 progress (for display purposes)
  double _getLayer1Progress() {
    // Find any Layer 1 element and calculate its progress towards center
    var layer1Element = elements.firstWhere((e) => e.layer == 1);
    Alignment currentPos = _getCurrentPosition(layer1Element, animationController.value);

    // Calculate distance from start to current position
    double startDistance = math.sqrt(
        layer1Element.startPosition.x * layer1Element.startPosition.x +
            layer1Element.startPosition.y * layer1Element.startPosition.y
    );
    double currentDistance = math.sqrt(
        currentPos.x * currentPos.x +
            currentPos.y * currentPos.y
    );

    // Progress is how much of the distance has been covered
    return ((startDistance - currentDistance) / startDistance).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text("Gravitational Pull Animation"),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          double layer1Progress = _getLayer1Progress();

          return Stack(
            children: [
              // Debug text to show progress
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.black54,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Animation: ${(animationController.value * 100).toStringAsFixed(1)}%',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        'Layer 1 to center: ${(layer1Progress * 100).toStringAsFixed(1)}%',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Layer 1: Active',
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      ),
                      Text(
                        'Layer 2: ${animationController.value >= 0.33 ? "Active" : "Waiting (at 33%)"}',
                        style: TextStyle(
                          color: animationController.value >= 0.33 ? Colors.green : Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Layer 3: ${animationController.value >= 0.66 ? "Active" : "Waiting (at 66%)"}',
                        style: TextStyle(
                          color: animationController.value >= 0.66 ? Colors.green : Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Animation elements
              ...elements.map((element) {
                double progress = animationController.value;
                Alignment currentPosition = _getCurrentPosition(element, progress);
                Map<String, double> stretch = _getStretch(element, progress);
                double opacity = _getOpacity(element, progress);
                double rotation = _getRotation(element);

                return Align(
                  alignment: currentPosition,
                  child: Opacity(
                    opacity: opacity,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateZ(rotation)
                        ..scale(stretch['scaleX'], stretch['scaleY'])
                        ..rotateZ(-rotation),
                      child: Container(
                        height: 24 + (element.layer * 2), // Larger elements in outer layers
                        width: 24 + (element.layer * 2),
                        decoration: BoxDecoration(
                          color: element.color.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: element.color.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '${element.id}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: startAnimation,
        backgroundColor: Colors.white,
        child: Icon(Icons.play_circle, color: Colors.black, size: 32),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class ElementData {
  final int id;
  final Alignment startPosition;
  final Color color;
  final int layer;
  final double startDelay;

  ElementData({
    required this.id,
    required this.startPosition,
    required this.color,
    required this.layer,
    required this.startDelay,
  });
}