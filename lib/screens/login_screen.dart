import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _handleLogin() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email == "admin@celoe.id" && password == "password123") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Berhasil! Selamat datang di celoe.'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email atau Password salah.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF111827) : Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      // Image
                      Positioned.fill(
                        child: Image.network(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDwQf6hk18HLhrRpppyzxOASp1jkfWITW4YaZ160awPsxA9RmJjaqfVpfxAhqPHksM4Bf-K0zOvajF5IgFhpxuSJDHSaAAC3EVpa5G4Xx8tfExAWLrVQ8SIkey6n2BYXerSSmsu-SzoQ0xk75awZ-D8C22lzrtTBMHW91_pl2ZzHrdlyKtyTGh5GusA8krctPuWMqBoeePNZ-ThYEVAbyOjLSMXDhU-32lt93D4SbG7-t2-cVt36l4CyWgz7eH6xLFWfpmzt6eYOHqb',
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.2),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      // Curve Bottom
                      Positioned(
                        bottom: -1,
                        left: 0,
                        right: 0,
                        child: CustomPaint(
                          size: Size(MediaQuery.of(context).size.width, 100),
                          painter: TopWavePainter(
                            color: isDark ? const Color(0xFF111827) : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Floating School Icon
                Positioned(
                  bottom: -40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFFc026d3), // Fuchsia 600
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? const Color(0xFF111827) : Colors.white,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60),

            // Form Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Username Field
                  TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                    decoration: InputDecoration(
                      labelText: 'Email 365',
                      labelStyle: GoogleFonts.poppins(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFc026d3), width: 2),
                      ),
                      floatingLabelStyle: const TextStyle(color: Color(0xFFc026d3)),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: GoogleFonts.poppins(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFc026d3), width: 2),
                      ),
                      floatingLabelStyle: const TextStyle(color: Color(0xFFc026d3)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 48),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFc026d3),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        elevation: 8,
                        shadowColor: const Color(0xFFc026d3).withOpacity(0.4),
                      ),
                      child: Text(
                        'Log In',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Bantuan ?',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFc026d3),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Footer Waves
            const SizedBox(height: 40),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                   CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 200),
                    painter: BottomWavePainter(
                      color: const Color(0xFFc026d3).withOpacity(0.3),
                      offset: 10,
                    ),
                  ),
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 200),
                    painter: BottomWavePainter(
                      color: const Color(0xFFc026d3),
                      offset: 0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopWavePainter extends CustomPainter {
  final Color color;
  TopWavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path();
    
    // HTML Wave path: M0,120 L1200,120 L1200,0 C1000,60 600,100 0,60 Z
    // Normalized to Flutter coordinates:
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.6, size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.6, 0, size.height * 0.5);
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class BottomWavePainter extends CustomPainter {
  final Color color;
  final double offset;
  BottomWavePainter({required this.color, this.offset = 0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path();
    
    // Wave logic inspired by HTML path
    path.moveTo(0, size.height * 0.5 + offset);
    path.cubicTo(
      size.width * 0.25, size.height * 0.4 + offset,
      size.width * 0.5, size.height * 0.7 + offset,
      size.width * 0.75, size.height * 0.45 + offset
    );
    path.lineTo(size.width, size.height * 0.6 + offset);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
