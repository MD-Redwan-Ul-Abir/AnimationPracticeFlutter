import 'package:flutter/material.dart';

class ElementMovingAnimation extends StatefulWidget {
  const ElementMovingAnimation({super.key});

  @override
  State<ElementMovingAnimation> createState() => _ElementMovingAnimationState();
}

class _ElementMovingAnimationState extends State<ElementMovingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("1. Element moving animation"),
        centerTitle: true,
      ),
      body: AnimatedBuilder(animation: animationController, builder: (context,child){
        return Align(
          alignment: Alignment(0*(1-animationController.value), -1*(1-animationController.value)),
          child: Container(height: 20, width: 20, color: Colors.red),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          animationController.reset();
          print("current value =====>> ${animationController.value}");
          animationController.forward();
        },
        child: Center(child: Icon(Icons.play_circle)),
      ),

    );
  }
}
