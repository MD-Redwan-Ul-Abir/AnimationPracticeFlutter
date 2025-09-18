import 'package:flutter/material.dart';

class MultiDirectionMovement extends StatefulWidget {
  const MultiDirectionMovement({super.key});

  @override
  State<MultiDirectionMovement> createState() => _MultiDirectionMovementState();
}

class _MultiDirectionMovementState extends State<MultiDirectionMovement> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  AlignmentTween alignmentTween = AlignmentTween(begin: Alignment.topLeft,end: Alignment.center);
  Animation<Alignment> animation = AlwaysStoppedAnimation(Alignment.topLeft);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("2. Element moving animation"),
        centerTitle: true,
      ),
      body: AnimatedBuilder(animation: animationController, builder: (context,child){
        return Align(
          alignment: animation.value,
          child: Container(height: 20, width: 20, color: Colors.pink),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          animationController.reset();
          print("current value =====>> ${animationController.value}");
          animationController.forward();
          animation = animationController.drive(alignmentTween.chain(CurveTween(curve: Curves.easeInOutBack)));
        },
        child: Center(child: Icon(Icons.play_circle)),
      ),

    );
  }
}
