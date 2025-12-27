import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:uas_saya/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8B5CF6), // Purple
              Color(0xFFEC4899), // Pink
            ],
          ),
        ),
        child: Stack(
          children: [
            // Decorative Circle Top Left
            Positioned(
              top: -MediaQuery.of(context).size.height * 0.1,
              left: -MediaQuery.of(context).size.width * 0.2,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: const BoxDecoration(
                    color: Colors.white10,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            // Decorative Circle Bottom Right
            Positioned(
              bottom: -MediaQuery.of(context).size.height * 0.1,
              right: -MediaQuery.of(context).size.width * 0.2,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
                child: Container(
                  width: 320,
                  height: 320,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            
            // Main Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   // Logo Area
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Backdrop glow
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ).animate().scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.5, 1.5),
                        duration: 3.seconds,
                        curve: Curves.easeInOut,
                      ).blur(begin: const Offset(10, 10), end: const Offset(20, 20)),
                      
                      CustomPaint(
                        size: const Size(140, 80),
                        painter: CeloeLogoPainter(),
                      ),
                    ],
                  ).animate().fadeIn(duration: 800.ms).moveY(begin: 20, end: 0, curve: Curves.easeOut),
                  
                  const SizedBox(height: 24),
                  
                  // Title
                  Text(
                    'celoe',
                    style: GoogleFonts.poppins(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      shadows: [
                        const Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 200.ms, duration: 800.ms).moveY(begin: 20, end: 0),
                  
                  // Subtitle
                  Text(
                    'LEARNING MANAGEMENT SYSTEM',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 2.0,
                    ),
                  ).animate().fadeIn(delay: 400.ms, duration: 800.ms).moveY(begin: 20, end: 0),
                ],
              ),
            ),
            
            // Bottom Section: Bouncing Dots & Version
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const BouncingDots(color: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    'Version 2.0.1',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 600.ms),
            ),
          ],
        ),
      ),
    );
  }
}

class CeloeLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path1 = Path();
    // M30 40C30 55 10 55 10 40C10 25 30 25 30 40Z
    path1.addOval(Rect.fromLTRB(10, 25, 30, 55));
    canvas.drawPath(path1, paint);

    final path2 = Path();
    // M30 40H45C55 40 55 55 65 55C75 55 75 40 85 40H110
    path2.moveTo(30, 40);
    path2.lineTo(45, 40);
    path2.cubicTo(55, 40, 55, 55, 65, 55);
    path2.cubicTo(75, 55, 75, 40, 85, 40);
    path2.lineTo(110, 40);
    canvas.drawPath(path2, paint);

    final path3 = Path();
    // M85 40C85 25 105 25 105 40C105 55 85 55 85 40Z
    path3.addOval(Rect.fromLTRB(85, 25, 105, 55));
    canvas.drawPath(path3, paint);

    final path4 = Path();
    // M110 40H125
    path4.moveTo(110, 40);
    path4.lineTo(125, 40);
    canvas.drawPath(path4, paint);

    final path5 = Path();
    // M65 25H90
    path5.moveTo(65, 25);
    path5.lineTo(90, 25);
    canvas.drawPath(path5, paint);

    final path6 = Path();
    // M65 25H40
    path6.moveTo(65, 25);
    path6.lineTo(40, 25);
    canvas.drawPath(path6, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BouncingDots extends StatefulWidget {
  final Color color;
  const BouncingDots({super.key, required this.color});

  @override
  State<BouncingDots> createState() => _BouncingDotsState();
}

class _BouncingDotsState extends State<BouncingDots> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0, end: -10).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    for (int i = 0; i < 3; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              transform: Matrix4.translationValues(0, _animations[index].value, 0),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
            );
          },
        );
      }),
    );
  }
}
