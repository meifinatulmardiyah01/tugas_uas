import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_saya/screens/help_screen.dart';
import 'package:uas_saya/screens/main_wrapper.dart';
import 'package:uas_saya/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  final _authService = AuthService();

  final Color primaryPurple = const Color(0xFF8B5CF6);
  final Color primaryPink = const Color(0xFFEC4899);
  final Color fuchsia600 = const Color(0xFFC026D3);

  void _handleLogin() {
    String username = _emailController.text;
    String password = _passwordController.text;

    if (_authService.validate(username, password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Berhasil! Selamat datang.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainWrapper()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username atau Password salah.'),
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
                          'https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
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
                              Colors.black.withValues(alpha: 0.3),
                              primaryPurple.withValues(alpha: 0.2),
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
                        gradient: LinearGradient(
                          colors: [primaryPurple, primaryPink],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? const Color(0xFF111827) : Colors.white,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: primaryPurple.withValues(alpha: 0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
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
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: fuchsia600, width: 2),
                      ),
                      floatingLabelStyle: TextStyle(color: fuchsia600),
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
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: fuchsia600, width: 2),
                      ),
                      floatingLabelStyle: TextStyle(color: fuchsia600),
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
                        backgroundColor: fuchsia600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        elevation: 8,
                        shadowColor: fuchsia600.withValues(alpha: 0.4),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HelpScreen()),
                      );
                    },
                    child: Text(
                      'Pusat Bantuan',
                      style: GoogleFonts.poppins(
                        color: fuchsia600,
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
                      color: fuchsia600.withValues(alpha: 0.3),
                      offset: 10,
                    ),
                  ),
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 200),
                    painter: BottomWavePainter(
                      color: fuchsia600,
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
