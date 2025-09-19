import 'package:flutter/material.dart';
import 'animatedSplashScreen.dart';


class AnimationDemoPatterns {
  // Simple circular orbit pattern
  static List<AnimatedElement> createSimpleOrbitPattern() {
    return [
      // Center element
      AnimatedElement(
        id: 'center',
        config: AnimationConfig(
          pathType: AnimationPathType.circular,
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
          parameters: {
            'radius': 0.05,
            'points': 10,
          },
          startPosition: Alignment.center,
          color: Colors.red,
          size: 20,
        ),
      ),

      // Orbiting elements
      ...List.generate(4, (index) {
        return AnimatedElement(
          id: 'orbit_$index',
          config: AnimationConfig(
            pathType: AnimationPathType.circular,
            duration: Duration(milliseconds: 2000),
            curve: Curves.linear,
            parameters: {
              'radius': 0.3,
              'points': 20,
              'startAngle': (index * 1.57), // 90 degrees apart
            },
            startPosition: Alignment.center,
            color: [Colors.blue, Colors.green, Colors.orange, Colors.purple][index],
            size: 15,
          ),
        );
      }),
    ];
  }

  // Solar system pattern
  static List<AnimatedElement> createSolarSystemPattern() {
    return [
      // Sun in center
      AnimatedElement(
        id: 'sun',
        config: AnimationConfig(
          pathType: AnimationPathType.circular,
          duration: Duration(milliseconds: 500),
          curve: Curves.linear,
          parameters: {
            'radius': 0.02,
            'points': 8,
          },
          startPosition: Alignment.center,
          color: Colors.yellow,
          size: 30,
        ),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Colors.yellow, Colors.orange],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 3,
              ),
            ],
          ),
        ),
      ),

      // Planets
      AnimatedElement(
        id: 'mercury',
        config: AnimationConfig(
          pathType: AnimationPathType.circular,
          duration: Duration(milliseconds: 1500),
          curve: Curves.linear,
          parameters: {
            'radius': 0.15,
            'points': 20,
          },
          startPosition: Alignment.center,
          color: Colors.grey,
          size: 8,
        ),
      ),

      AnimatedElement(
        id: 'earth',
        config: AnimationConfig(
          pathType: AnimationPathType.circular,
          duration: Duration(milliseconds: 3000),
          curve: Curves.linear,
          parameters: {
            'radius': 0.25,
            'points': 30,
          },
          startPosition: Alignment.center,
          color: Colors.blue,
          size: 12,
        ),
      ),

      AnimatedElement(
        id: 'mars',
        config: AnimationConfig(
          pathType: AnimationPathType.circular,
          duration: Duration(milliseconds: 4500),
          curve: Curves.linear,
          parameters: {
            'radius': 0.35,
            'points': 40,
          },
          startPosition: Alignment.center,
          color: Colors.red,
          size: 10,
        ),
      ),
    ];
  }

  // Butterfly pattern
  static List<AnimatedElement> createButterflyPattern() {
    return [
      // Main butterfly body
      AnimatedElement(
        id: 'butterfly_body',
        config: AnimationConfig(
          pathType: AnimationPathType.figureEight,
          duration: Duration(milliseconds: 4000),
          curve: Curves.easeInOut,
          parameters: {
            'radius': 0.4,
            'points': 50,
          },
          startPosition: Alignment.center,
          color: Colors.purple,
          size: 15,
        ),
      ),

      // Wing particles
      ...List.generate(8, (index) {
        return AnimatedElement(
          id: 'wing_particle_$index',
          config: AnimationConfig(
            pathType: AnimationPathType.figureEight,
            duration: Duration(milliseconds: 4000 + index * 100),
            curve: Curves.easeInOut,
            parameters: {
              'radius': 0.3 + (index * 0.02),
              'points': 40,
            },
            startPosition: Alignment.center,
            color: [
              Colors.pink,
              Colors.lightBlue,
              Colors.amber,
              Colors.lightGreen,
              Colors.deepOrange,
              Colors.indigo,
              Colors.teal,
              Colors.lime,
            ][index].withOpacity(0.7),
            size: 8,
          ),
        );
      }),
    ];
  }

  // DNA Helix pattern
  static List<AnimatedElement> createDNAHelixPattern() {
    return [
      // DNA strands
      ...List.generate(20, (index) {
        double phase = (index / 10) * 3.14159; // Phase shift
        return AnimatedElement(
          id: 'dna_strand_$index',
          config: AnimationConfig(
            pathType: AnimationPathType.wave,
            duration: Duration(milliseconds: 5000),
            curve: Curves.linear,
            parameters: {
              'frequency': 2.0,
              'amplitude': 0.3,
              'points': 50,
            },
            startPosition: Alignment.topCenter,
            endPosition: Alignment.bottomCenter,
            color: index % 2 == 0 ? Colors.blue : Colors.red,
            size: 6,
          ),
        );
      }),

      // Connecting bonds
      ...List.generate(10, (index) {
        return AnimatedElement(
          id: 'bond_$index',
          config: AnimationConfig(
            pathType: AnimationPathType.linear,
            duration: Duration(milliseconds: 3000 + index * 200),
            curve: Curves.easeInOut,
            startPosition: Alignment.centerLeft,
            endPosition: Alignment.centerRight,
            color: Colors.yellow.withOpacity(0.8),
            size: 4,
          ),
        );
      }),
    ];
  }

  // Fireworks pattern
  static List<AnimatedElement> createFireworksPattern() {
    return [
      // Central burst
      AnimatedElement(
        id: 'burst_center',
        config: AnimationConfig(
          pathType: AnimationPathType.circular,
          duration: Duration(milliseconds: 2000),
          curve: Curves.easeOut,
          parameters: {
            'radius': 0.1,
            'points': 15,
          },
          startPosition: Alignment.center,
          color: Colors.white,
          size: 12,
        ),
      ),

      // Radiating sparks
      ...List.generate(16, (index) {
        double angle = (index * 22.5) * (3.14159 / 180); // Convert to radians
        return AnimatedElement(
          id: 'spark_$index',
          config: AnimationConfig(
            pathType: AnimationPathType.spiral,
            duration: Duration(milliseconds: 3000 + index * 50),
            curve: Curves.easeOut,
            parameters: {
              'maxRadius': 0.6 + (index % 4) * 0.1,
              'turns': 0.5,
              'points': 30,
            },
            startPosition: Alignment.center,
            color: [
              Colors.red,
              Colors.orange,
              Colors.yellow,
              Colors.green,
              Colors.blue,
              Colors.purple,
              Colors.pink,
              Colors.cyan,
            ][index % 8],
            size: 8,
          ),
        );
      }),
    ];
  }

  // Galaxy spiral pattern
  static List<AnimatedElement> createGalaxySpiralPattern() {
    return [
      // Galaxy center
      AnimatedElement(
        id: 'galaxy_center',
        config: AnimationConfig(
          pathType: AnimationPathType.circular,
          duration: Duration(milliseconds: 1000),
          curve: Curves.linear,
          parameters: {
            'radius': 0.05,
            'points': 12,
          },
          startPosition: Alignment.center,
          color: Colors.white,
          size: 20,
        ),
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Colors.white, Colors.yellow, Colors.orange],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                blurRadius: 15,
                spreadRadius: 5,
              ),
            ],
          ),
        ),
      ),

      // Spiral arms
      ...List.generate(30, (index) {
        return AnimatedElement(
          id: 'star_$index',
          config: AnimationConfig(
            pathType: AnimationPathType.spiral,
            duration: Duration(milliseconds: 8000 + index * 100),
            curve: Curves.linear,
            parameters: {
              'maxRadius': 0.8,
              'turns': 3.0 + (index * 0.1),
              'points': 60,
            },
            startPosition: Alignment.center,
            color: [
              Colors.white,
              Colors.lightBlue,
              Colors.yellow,
              Colors.orange,
              Colors.red,
            ][index % 5].withOpacity(0.8),
            size: 4 + (index % 3),
          ),
        );
      }),
    ];
  }

  // Heartbeat pattern
  static List<AnimatedElement> createHeartbeatPattern() {
    return [
      // Main heart
      AnimatedElement(
        id: 'heart',
        config: AnimationConfig(
          pathType: AnimationPathType.bounce,
          duration: Duration(milliseconds: 2000),
          curve: Curves.elasticInOut,
          parameters: {
            'bounces': 2,
            'bounceHeight': 0.05,
          },
          startPosition: Alignment.center,
          endPosition: Alignment.center,
        ),
        child: Icon(
          Icons.favorite,
          color: Colors.red,
          size: 50,
        ),
      ),

      // Pulse rings
      ...List.generate(3, (index) {
        return AnimatedElement(
          id: 'pulse_ring_$index',
          config: AnimationConfig(
            pathType: AnimationPathType.circular,
            duration: Duration(milliseconds: 2000 + index * 300),
            curve: Curves.easeOut,
            parameters: {
              'radius': 0.2 + (index * 0.15),
              'points': 20,
            },
            startPosition: Alignment.center,
            color: Colors.red.withOpacity(0.3 - index * 0.1),
            size: 6,
          ),
        );
      }),
    ];
  }

  // Random chaos pattern
  static List<AnimatedElement> createChaosPattern() {
    List<AnimatedElement> elements = [];

    for (int i = 0; i < 15; i++) {
      AnimationPathType randomPath = AnimationPathType.values[i % AnimationPathType.values.length];

      elements.add(
        AnimatedElement(
          id: 'chaos_$i',
          config: AnimationConfig(
            pathType: randomPath,
            duration: Duration(milliseconds: 2000 + i * 200),
            curve: [
              Curves.linear,
              Curves.easeIn,
              Curves.easeOut,
              Curves.bounceIn,
              Curves.elasticOut,
            ][i % 5],
            parameters: {
              'radius': 0.2 + (i % 5) * 0.1,
              'points': 20 + i * 2,
              'frequency': 1.0 + i * 0.5,
              'amplitude': 0.2 + (i % 3) * 0.1,
              'zigzags': 2 + i % 4,
              'maxRadius': 0.5 + i * 0.05,
              'turns': 1.0 + i * 0.3,
              'bounces': 2 + i % 3,
              'bounceHeight': 0.1 + (i % 2) * 0.1,
            },
            startPosition: [
              Alignment.topLeft,
              Alignment.topCenter,
              Alignment.topRight,
              Alignment.centerLeft,
              Alignment.center,
              Alignment.centerRight,
              Alignment.bottomLeft,
              Alignment.bottomCenter,
              Alignment.bottomRight,
            ][i % 9],
            endPosition: [
              Alignment.bottomRight,
              Alignment.bottomCenter,
              Alignment.bottomLeft,
              Alignment.centerRight,
              Alignment.center,
              Alignment.centerLeft,
              Alignment.topRight,
              Alignment.topCenter,
              Alignment.topLeft,
            ][i % 9],
            color: Colors.primaries[i % Colors.primaries.length].withOpacity(0.8),
            size: 8 + (i % 4) * 2,
          ),
        ),
      );
    }

    return elements;
  }
}