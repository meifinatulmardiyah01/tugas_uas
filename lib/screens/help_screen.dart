import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  String _currentLang = 'ID';
  final Color primaryColor = const Color(0xFFC026D3); // Fuchsia 600

  final Map<String, Map<String, String>> _localizedText = {
    'EN': {
      'title': 'Help Center',
      'welcome': 'How can we help you?',
      'username_title': 'Username Format',
      'username_desc': 'Use your 365 email ending with .ac.id',
      'password_title': 'Default Password',
      'password_desc': 'Your password is not empty.',
      'failed_title': 'Login Failed?',
      'failed_desc': 'Ensure your internet connection is stable and credentials are correct.',
      'contact_title': 'Contact Support',
      'contact_desc': 'Need more help? Our team is here for you 24/7.',
      'contact_btn': 'Chat with Support',
    },
    'ID': {
      'title': 'Pusat Bantuan',
      'welcome': 'Ada yang bisa kami bantu?',
      'username_title': 'Format Username',
      'username_desc': 'Gunakan email 365 Anda yang berakhiran .ac.id',
      'password_title': 'Password Default',
      'password_desc': 'Password Anda tidak boleh kosong.',
      'failed_title': 'Gagal Login?',
      'failed_desc': 'Pastikan koneksi internet stabil dan kredensial sudah benar.',
      'contact_title': 'Hubungi Bantuan',
      'contact_desc': 'Butuh bantuan lebih? Tim kami siap melayani 24/7.',
      'contact_btn': 'Chat Sekarang',
    },
  };

  void _toggleLanguage(String lang) {
    if (_currentLang != lang) {
      setState(() {
        _currentLang = lang;
      });
    }
  }

  Future<void> _launchWhatsApp() async {
    final Uri url = Uri.parse('https://wa.me/6281234567890');
    if (!await launchUrl(url)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak dapat membuka WhatsApp')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final text = _localizedText[_currentLang]!;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF111827) : const Color(0xFFF9FAFB),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            floating: false,
            pinned: true,
            backgroundColor: primaryColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -50,
                      right: -50,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          const Icon(Icons.support_agent_rounded, size: 64, color: Colors.white),
                          const SizedBox(height: 16),
                          Text(
                            text['title']!,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Language Toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       _buildLangBtn('ID', 'Indonesia', 'https://flagcdn.com/w40/id.png'),
                      const SizedBox(width: 12),
                      _buildLangBtn('EN', 'English', 'https://flagcdn.com/w40/gb.png'),
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  Text(
                    text['welcome']!,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  _buildHelpCard(
                    icon: Icons.alternate_email_rounded,
                    title: text['username_title']!,
                    desc: text['username_desc']!,
                    iconBg: const Color(0xFFEDE9FE),
                    iconColor: const Color(0xFF8B5CF6),
                  ),
                  const SizedBox(height: 16),
                  _buildHelpCard(
                    icon: Icons.lock_outline_rounded,
                    title: text['password_title']!,
                    desc: text['password_desc']!,
                    iconBg: const Color(0xFFFCE7F3),
                    iconColor: const Color(0xFFEC4899),
                  ),
                  const SizedBox(height: 16),
                  _buildHelpCard(
                    icon: Icons.wifi_off_rounded,
                    title: text['failed_title']!,
                    desc: text['failed_desc']!,
                    iconBg: const Color(0xFFFFF7ED),
                    iconColor: Colors.orange,
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Contact Section
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF8B5CF6).withValues(alpha: 0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          text['contact_title']!,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          text['contact_desc']!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _launchWhatsApp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                            elevation: 0,
                          ),
                          child: Text(
                            text['contact_btn']!,
                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLangBtn(String code, String label, String flagUrl) {
    bool isSelected = _currentLang == code;
    return GestureDetector(
      onTap: () => _toggleLanguage(code),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: isSelected ? primaryColor : Colors.grey[300]!),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Image.network(
                flagUrl,
                width: 20,
                height: 15,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpCard({
    required IconData icon,
    required String title,
    required String desc,
    required Color iconBg,
    required Color iconColor,
  }) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1F2937) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[100]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                Text(
                  desc,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
