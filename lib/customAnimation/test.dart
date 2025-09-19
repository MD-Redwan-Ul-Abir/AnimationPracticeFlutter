import 'package:flutter/material.dart';
import 'animatedSplashScreen.dart';


class TestCaseAnimation extends StatefulWidget {
  const TestCaseAnimation({super.key});

  @override
  State<TestCaseAnimation> createState() => _TestCaseAnimationState();
}

class _TestCaseAnimationState extends State<TestCaseAnimation> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    // Auto navigate after 6 seconds
    Future.delayed(Duration(seconds: 6), () {
      if (mounted) {
        setState(() {
          _showSplash = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return _buildSplashScreen();
    } else {
      return _buildMainContent();
    }
  }

  Widget _buildSplashScreen() {
    // Create animated elements list
    final List<AnimatedElement> elements = [
      // Central logo with pulsing effect
      AnimatedElement(
        id: 'centralLogo',
        config: AnimationConfig(
          pathType: AnimationPathType.circular,
          duration: Duration(milliseconds: 2000),
           curve: Curves.easeInOut,
          parameters: {
            'radius': 0.0,
            'centerX': 0.0,
            'centerY': 0.0,
            'points': 20,
          },
          startPosition: Alignment.center,
        ),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.deepPurple, Colors.purple.shade300],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withOpacity(0.5),
                blurRadius: 15,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Icon(
            Icons.rocket_launch,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),

      // Orbiting particles
      ...List.generate(6, (index) {
        return AnimatedElement(
          id: 'orbit_$index',
          config: AnimationConfig(
            pathType: AnimationPathType.circular,
            duration: Duration(milliseconds: 3000 + index * 100),
            curve: Curves.linear,
            parameters: {
              'radius': 0.35,
              'centerX': 0.0,
              'centerY': 0.0,
              'points': 30,
              'startAngle': (index * 1.047), // 60 degrees apart
            },
            startPosition: Alignment.center,
            color: [
              Colors.red,
              Colors.orange,
              Colors.yellow,
              Colors.green,
              Colors.blue,
              Colors.purple,
            ][index],
            size: 8,
          ),
        );
      }),

      // Figure-8 dancing elements
      // AnimatedElement(
      //   id: 'figure8_1',
      //   config: AnimationConfig(
      //     pathType: AnimationPathType.figureEight,
      //     duration: Duration(milliseconds: 4000),
      //     curve: Curves.easeInOut,
      //     parameters: {
      //       'radius': 0.6,
      //       'points': 50,
      //       'centerX': -0.3,
      //       'centerY': 0.0,
      //     },
      //     startPosition: Alignment.centerLeft,
      //     color: Colors.cyan.withOpacity(0.8),
      //     size: 12,
      //   ),
      // ),

      // AnimatedElement(
      //   id: 'figure8_2',
      //   config: AnimationConfig(
      //     pathType: AnimationPathType.figureEight,
      //     duration: Duration(milliseconds: 3500),
      //     curve: Curves.easeInOut,
      //     parameters: {
      //       'radius': 0.6,
      //       'points': 50,
      //       'centerX': 0.3,
      //       'centerY': 0.0,
      //     },
      //     startPosition: Alignment.centerRight,
      //     color: Colors.pink.withOpacity(0.8),
      //     size: 12,
      //   ),
      // ),

      // Spiral from corners
      AnimatedElement(
        id: 'spiral_topLeft',
        config: AnimationConfig(
          pathType: AnimationPathType.spiral,
          duration: Duration(milliseconds: 5000),
          curve: Curves.easeOut,
          parameters: {
            'maxRadius': 0.9,
            'turns': 2.5,
            'points': 60,
          },
          startPosition: Alignment.topLeft,
          color: Colors.lime.withOpacity(0.7),
          size: 6,
        ),
      ),

      AnimatedElement(
        id: 'spiral_bottomRight',
        config: AnimationConfig(
          pathType: AnimationPathType.spiral,
          duration: Duration(milliseconds: 4500),
          curve: Curves.easeOut,
          parameters: {
            'maxRadius': 0.9,
            'turns': 2.5,
            'points': 60,
          },
          startPosition: Alignment.bottomRight,
          color: Colors.teal.withOpacity(0.7),
          size: 6,
        ),
      ),

      // Wave effects
      AnimatedElement(
        id: 'wave_horizontal',
        config: AnimationConfig(
          pathType: AnimationPathType.wave,
          duration: Duration(milliseconds: 3000),
          curve: Curves.easeInOut,
          parameters: {
            'frequency': 3.0,
            'amplitude': 0.25,
            'points': 40,
          },
          startPosition: Alignment.centerLeft,
          endPosition: Alignment.centerRight,
          color: Colors.amber.withOpacity(0.6),
          size: 10,
        ),
      ),

      // Bouncing title
      // AnimatedElement(
      //   id: 'title',
      //   config: AnimationConfig(
      //     pathType: AnimationPathType.bounce,
      //     duration: Duration(milliseconds: 2500),
      //     curve: Curves.bounceOut,
      //     parameters: {
      //       'bounces': 3,
      //       'bounceHeight': 0.15,
      //     },
      //     startPosition: Alignment.topCenter,
      //     endPosition: Alignment(0.0, -0.6),
      //   ),
      //   child: Container(
      //     padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [Colors.deepPurple, Colors.purple.shade300],
      //       ),
      //       borderRadius: BorderRadius.circular(30),
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.deepPurple.withOpacity(0.3),
      //           blurRadius: 10,
      //           offset: Offset(0, 5),
      //         ),
      //       ],
      //     ),
      //     child: Text(
      //       'Flutter Demo',
      //       style: TextStyle(
      //         color: Colors.white,
      //         fontSize: 20,
      //         fontWeight: FontWeight.bold,
      //         letterSpacing: 1.5,
      //       ),
      //     ),
      //   ),
      // ),

      // Zigzag particles
      AnimatedElement(
        id: 'zigzag_1',
        config: AnimationConfig(
          pathType: AnimationPathType.zigzag,
          duration: Duration(milliseconds: 3500),
          curve: Curves.easeInOut,
          parameters: {
            'zigzags': 4,
            'amplitude': 0.2,
          },
          startPosition: Alignment.topRight,
          endPosition: Alignment.bottomLeft,
          color: Colors.indigo.withOpacity(0.7),
          size: 8,
        ),
      ),
    ];

    // Create splash controller
    final splashController = SplashAnimationController(
      elements: elements,
      onAnimationComplete: () {
        if (mounted) {
          setState(() {
            _showSplash = false;
          });
        }
      },
    );

    return AnimatedSplashScreen(
      controller: splashController,
      backgroundColor: Colors.black,
      backgroundWidget: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [
              Colors.deepPurple.withOpacity(0.4),
              Colors.black,
              Colors.indigo.withOpacity(0.3),
              Colors.black,
            ],
            stops: [0.0, 0.4, 0.8, 1.0],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Case Animation'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              'Animation Test Complete!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Splash screen animation finished successfully',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showSplash = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text('Replay Animation'),
            ),
          ],
        ),
      ),
    );
  }
}