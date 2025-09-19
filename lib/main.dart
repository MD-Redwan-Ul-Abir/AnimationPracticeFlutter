// import 'package:flutter/material.dart';
//
// import '1_ElementMovingAnimation.dart';
// import '2.ElementMovingAnimationUsingTwine.dart';
// import '3.0_ElementMovingMultidirection.dart';
// import '3.1_ElementMovingMultidirection.dart';
// import '4._MultipleElements.dart';
// import 'fireWorkAnimation.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home:   ElementMovingWithMultidirection( ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '1_ElementMovingAnimation.dart';
import '2.ElementMovingAnimationUsingTwine.dart';
import '3.0_ElementMovingMultidirection.dart';
import '3.1_ElementMovingMultidirection.dart';
import '4._MultipleElements.dart';
import 'customAnimation/test.dart';
import 'fireWorkAnimation.dart';
  // Import the updated test file

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
        useMaterial3: true,
      ),
      // Use TestCaseAnimation instead of ElementMovingWithMultidirection
      home: TwineAnimationExample(),
    );
  }
}
