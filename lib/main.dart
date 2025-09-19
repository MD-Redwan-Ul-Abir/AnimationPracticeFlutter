import 'package:flutter/material.dart';

import '1_ElementMovingAnimation.dart';
import '2.ElementMovingAnimationUsingTwine.dart';
import '3.ElementMovingMultidirection.dart';
import '4._MultipleElements.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:   CustomPathAnimation( ),
    );
  }
}
