import 'package:flutter/material.dart';

class MultiDirectionMovementSegmented extends StatefulWidget {
  const MultiDirectionMovementSegmented({super.key});

  @override
  State<MultiDirectionMovementSegmented> createState() => _MultiDirectionMovementSegmentedState();
}

class _MultiDirectionMovementSegmentedState extends State<MultiDirectionMovementSegmented>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Alignment> animation1;
  late Animation<Alignment> animation2;
  late Animation<Alignment> animation3;
  late Animation<Alignment> animation4;
  late Animation<Alignment> animation5;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 6000),
    );

    // Create individual animations for each segment with easeInOutBack curve
    animation1 = AlignmentTween(
      begin: Alignment(-0.9, -0.9),
      end: Alignment(0.9, -0.9),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.0, 0.2, curve: Curves.easeInOutBack),
    ));

    animation2 = AlignmentTween(
      begin: Alignment(0.9, -0.9),
      end: Alignment(0.9, 0.9),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.2, 0.4, curve: Curves.easeInOutBack),
    ));

    animation3 = AlignmentTween(
      begin: Alignment(0.9, 0.9),
      end: Alignment(-0.9, 0.9),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.4, 0.6, curve: Curves.easeInOutBack),
    ));

    animation4 = AlignmentTween(
      begin: Alignment(-0.9, 0.9),
      end: Alignment(-0.9, -0.9),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.6, 0.8, curve: Curves.easeInOutBack),
    ));

    animation5 = AlignmentTween(
      begin: Alignment(-0.9, -0.9),
      end: Alignment(0, 0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.8, 1.0, curve: Curves.easeInOutBack),
    ));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Alignment getCurrentAlignment() {
    double progress = animationController.value;

    if (progress <= 0.2) {
      return animation1.value;
    } else if (progress <= 0.4) {
      return animation2.value;
    } else if (progress <= 0.6) {
      return animation3.value;
    } else if (progress <= 0.8) {
      return animation4.value;
    } else {
      return animation5.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("2. Element moving animation (Segmented EaseInOutBack)"),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Align(
            alignment: getCurrentAlignment(),
            child: Container(height: 20, width: 20, color: Colors.pink),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (animationController.isAnimating) {
            animationController.stop();
            animationController.reset();
          } else {
            animationController.reset();
            print("current value =====>> ${animationController.value}");
            animationController.forward();
          }
        },
        child: Center(
          child: Icon(
            animationController.isAnimating ? Icons.stop : Icons.play_circle,
          ),
        ),
      ),
    );
  }
}