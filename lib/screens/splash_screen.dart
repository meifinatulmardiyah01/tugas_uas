import 'dart:async';
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
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
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
            colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
          ),
        ),
        child: Stack(
          children: [
            // Decorative background circles
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              left: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo container
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                    child: Center(
                      child: CustomPaint(
                        size: const Size(100, 100),
                        painter: LogoPainter(),
                      ),
                    ),
                  ).animate().scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    duration: 1200.ms,
                    curve: Curves.elasticOut,
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Brand Name
                  Text(
                    'celoe',
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -1.0,
                    ),
                  ).animate().fadeIn(delay: 200.ms, duration: 800.ms).moveY(begin: 20, end: 0),
                  
                  // Tagline
                  Text(
                    'LEARNING MANAGEMENT SYSTEM',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.9),
                      letterSpacing: 2.0,
                    ),
                  ).animate().fadeIn(delay: 400.ms, duration: 800.ms).moveY(begin: 20, end: 0),
                  
                  const SizedBox(height: 60),
                  
                  // Bouncing Dots Loading
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDot(0, Colors.white),
                      const SizedBox(width: 8),
                      _buildDot(0.2, Colors.white),
                      const SizedBox(width: 8),
                      _buildDot(0.4, Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(double delay, Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.4),
        shape: BoxShape.circle,
      ),
    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
    .scale(
      begin: const Offset(1, 1),
      end: const Offset(1.5, 1.5),
      duration: 600.ms,
      delay: (delay * 1000).ms,
      curve: Curves.easeInOut,
    );
  }
}

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Simplified celoe "c" / smile shape inspired by HTML designs
    final path = Path();
    path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    
    // Create an inner cutout
    final innerPath = Path();
    innerPath.addOval(Rect.fromLTWH(size.width * 0.2, size.height * 0.2, size.width * 0.6, size.height * 0.6));
    
    final finalPath = Path.combine(PathOperation.difference, path, innerPath);
    
    // Add "smile" gap
    final gapPath = Path();
    gapPath.addRect(Rect.fromLTWH(size.width * 0.6, size.height * 0.2, size.width * 0.5, size.height * 0.3));
    
    final finalLogoPath = Path.combine(PathOperation.difference, finalPath, gapPath);
    
    canvas.drawPath(finalLogoPath, paint);
    
    // Add a dot
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.25), size.width * 0.1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
