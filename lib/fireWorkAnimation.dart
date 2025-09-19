import 'package:flutter/material.dart';
import 'dart:math' as math;

class FireworkSplashScreen extends StatefulWidget {
  const FireworkSplashScreen({super.key});

  @override
  State<FireworkSplashScreen> createState() => _FireworkSplashScreenState();
}

class _FireworkSplashScreenState extends State<FireworkSplashScreen>
    with TickerProviderStateMixin {

  // Animation controllers
  late AnimationController fireworkController;
  late AnimationController logoController;
  late AnimationController backgroundController;

  // Animations
  late Animation<double> fireworkAnimation;
  late Animation<double> logoScaleAnimation;
  late Animation<double> logoOpacityAnimation;
  late Animation<Color?> backgroundColorAnimation;

  // Product images data (you can replace these with your actual product images)
  final List<ProductParticle> particles = [];
  final List<String> productImages = [
    '🍿', '🎯', '🎮', '📱', '💎', '🎈', '🌟', '🎪', '🎭', '🎨'
  ]; // Replace with actual image paths

  bool showLogo = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    fireworkController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    backgroundController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Setup animations
    fireworkAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: fireworkController, curve: Curves.easeOut)
    );

    logoScaleAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: logoController, curve: Curves.elasticOut)
    );

    logoOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: logoController, curve: Curves.easeIn)
    );

    backgroundColorAnimation = ColorTween(
      begin: Colors.black,
      end: Colors.deepPurple.shade900,
    ).animate(CurvedAnimation(
        parent: backgroundController,
        curve: Curves.easeInOut
    ));

    // Generate particles
    _generateParticles();

    // Start the sequence
    _startAnimationSequence();
  }

  void _generateParticles() {
    final random = math.Random();
    for (int i = 0; i < 15; i++) {
      particles.add(ProductParticle(
        productImage: productImages[random.nextInt(productImages.length)],
        startAngle: random.nextDouble() * 2 * math.pi,
        speed: 150 + random.nextDouble() * 100,
        size: 30 + random.nextDouble() * 20,
        color: _getRandomColor(),
      ));
    }
  }

  Color _getRandomColor() {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.yellow,
      Colors.cyan,
    ];
    return colors[math.Random().nextInt(colors.length)];
  }

  void _startAnimationSequence() async {
    // Start firework animation
    fireworkController.forward();

    // Wait for firework to complete, then start logo and background
    await Future.delayed(const Duration(milliseconds: 2500));
    setState(() {
      showLogo = true;
    });

    logoController.forward();
    backgroundController.forward();
  }

  @override
  void dispose() {
    fireworkController.dispose();
    logoController.dispose();
    backgroundController.dispose();
    super.dispose();
  }

  Offset _getParticlePosition(ProductParticle particle, double progress, Size screenSize) {
    final centerX = screenSize.width / 2;
    final centerY = screenSize.height / 2;

    // Calculate distance from center based on progress
    final distance = particle.speed * progress;

    // Calculate position using polar coordinates
    final x = centerX + distance * math.cos(particle.startAngle);
    final y = centerY + distance * math.sin(particle.startAngle);

    return Offset(x, y);
  }

  double _getParticleOpacity(double progress) {
    if (progress < 0.3) return (progress / 0.3).clamp(0.0, 1.0); // Fade in
    if (progress > 0.7) return (1 - ((progress - 0.7) / 0.3)).clamp(0.0, 1.0); // Fade out
    return 1.0; // Full opacity in middle
  }

  double _getParticleScale(double progress) {
    if (progress < 0.2) return (progress / 0.2).clamp(0.0, 1.0); // Scale up
    if (progress > 0.8) return (1 - ((progress - 0.8) / 0.2) * 0.5).clamp(0.0, 1.0); // Scale down slightly
    return 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          fireworkAnimation,
          logoScaleAnimation,
          backgroundColorAnimation
        ]),
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  backgroundColorAnimation.value ?? Colors.black,
                  (backgroundColorAnimation.value ?? Colors.black).withOpacity(0.8),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Firework particles
                ...particles.map((particle) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final screenSize = Size(constraints.maxWidth, constraints.maxHeight);
                      final position = _getParticlePosition(
                          particle,
                          fireworkAnimation.value,
                          screenSize
                      );

                      final opacity = _getParticleOpacity(fireworkAnimation.value);
                      final scale = _getParticleScale(fireworkAnimation.value);

                      return Positioned(
                        left: position.dx - particle.size / 2,
                        top: position.dy - particle.size / 2,
                        child: Transform.scale(
                          scale: scale,
                          child: Opacity(
                            opacity: opacity,
                            child: Container(
                              width: particle.size,
                              height: particle.size,
                              decoration: BoxDecoration(
                                color: particle.color,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: particle.color.withOpacity(0.5),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  particle.productImage,
                                  style: TextStyle(
                                    fontSize: particle.size * 0.6,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),

                // Logo
                if (showLogo)
                  Center(
                    child: Transform.scale(
                      scale: logoScaleAnimation.value,
                      child: Opacity(
                        opacity: logoOpacityAnimation.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.star,
                                size: 60,
                                color: Colors.deepPurple,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "YOUR LOGO",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                // Restart button (for demo purposes)
                Positioned(
                  bottom: 50,
                  right: 20,
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      setState(() {
                        showLogo = false;
                      });
                      fireworkController.reset();
                      logoController.reset();
                      backgroundController.reset();
                      _startAnimationSequence();
                    },
                    child: const Icon(Icons.replay),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProductParticle {
  final String productImage; // Replace with actual image path/asset
  final double startAngle;
  final double speed;
  final double size;
  final Color color;

  ProductParticle({
    required this.productImage,
    required this.startAngle,
    required this.speed,
    required this.size,
    required this.color,
  });
}

// Example usage in main.dart or navigation
class SplashScreenDemo extends StatelessWidget {
  const SplashScreenDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firework Splash Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const FireworkSplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}