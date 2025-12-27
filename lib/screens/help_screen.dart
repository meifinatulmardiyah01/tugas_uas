import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  String _language = 'EN'; // 'ID' or 'EN'

  final Map<String, Map<String, String>> _localizedText = {
    'EN': {
      'title': 'Login Help',
      'subtitle': 'Instructions for Telkom University LMS',
      'restricted_title': 'Access Restricted',
      'restricted_desc': 'Only available for Lecturers and Students of Telkom University.',
      'credentials_title': 'Credentials Format',
      'username_label': 'Username',
      'username_desc': 'Any username followed by the suffix:',
      'password_label': 'Password',
      'password_desc': 'Use your SSO / iGracias account password.',
      'failed_title': 'Login Failed?',
      'failed_desc': 'If authentication fails, you may not have updated your password to a "Strong Password".',
      'failed_info': 'Please change your password in iGracias.',
      'helpdesk_title': 'CeLOE Helpdesk',
      'email_support': 'Email Support',
      'wa_support': 'WhatsApp',
    },
    'ID': {
      'title': 'Bantuan Login',
      'subtitle': 'Instruksi untuk LMS Telkom University',
      'restricted_title': 'Akses Terbatas',
      'restricted_desc': 'Hanya tersedia untuk Dosen dan Mahasiswa Telkom University.',
      'credentials_title': 'Format Kredensial',
      'username_label': 'Username',
      'username_desc': 'Nama apa saja yang diakhiri dengan:',
      'password_label': 'Password',
      'password_desc': 'Gunakan kata sandi akun SSO / iGracias Anda.',
      'failed_title': 'Gagal Login?',
      'failed_desc': 'Jika autentikasi gagal, Anda mungkin belum memperbarui kata sandi menjadi "Strong Password".',
      'failed_info': 'Silakan ganti kata sandi Anda di iGracias.',
      'helpdesk_title': 'CeLOE Helpdesk',
      'email_support': 'Dukungan Email',
      'wa_support': 'WhatsApp',
    }
  };

  void _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'infoceloe@telkomuniversity.ac.id',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  void _launchWhatsApp() async {
    final Uri whatsappUri = Uri.parse("https://wa.me/6282116663563");
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final text = _localizedText[_language]!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFc026d3), // Fuchsia 600
              Color(0xFF7c3aed), // Violet 600
              Color(0xFF3730a3), // Indigo 800
            ],
          ),
        ),
        child: Stack(
          children: [
            // Decorative Circles
            Positioned(
              top: 40,
              left: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 150,
              right: -20,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.pinkAccent.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Column(
              children: [
                const SizedBox(height: 50),
                // Drag handle look-alike
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Back Button for usability
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    padding: const EdgeInsets.only(left: 20),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF0f172a) : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, -10),
                        ),
                      ],
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: SingleChildScrollView(
                        key: ValueKey(_language),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Language Switcher
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildLanguageButton('ID', '🇮🇩'),
                                const SizedBox(width: 20),
                                Container(height: 30, width: 1, color: Colors.grey.withValues(alpha: 0.3)),
                                const SizedBox(width: 20),
                                _buildLanguageButton('EN', '🇬🇧'),
                              ],
                            ),
                            const SizedBox(height: 24),

                          Center(
                            child: Column(
                              children: [
                                Text(
                                  text['title']!,
                                  style: GoogleFonts.inter(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  text['subtitle']!,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Access Restricted Alert
                          _buildCard(
                            color: isDark ? Colors.blue[900]!.withValues(alpha: 0.2) : const Color(0xFFEFF6FF),
                            borderColor: Colors.blue.withValues(alpha: 0.1),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.school, size: 16, color: Colors.white),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        text['restricted_title']!,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[800],
                                        ),
                                      ),
                                      Text(
                                        text['restricted_desc']!,
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: Colors.blue[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Credentials Section
                          _buildSectionHeader(Icons.lock_person, text['credentials_title']!),
                          const SizedBox(height: 12),
                          _buildInfoCard(Icons.person, text['username_label']!, text['username_desc']!, 
                            code: '.ac.id'),
                          const SizedBox(height: 12),
                          _buildInfoCard(Icons.vpn_key, text['password_label']!, text['password_desc']!),
                          
                          const SizedBox(height: 32),

                          // Login Failed Section
                          _buildSectionHeader(Icons.warning_rounded, text['failed_title']!, iconColor: Colors.orange),
                          const SizedBox(height: 12),
                          _buildCard(
                            color: Colors.orange.withValues(alpha: 0.05),
                            borderColor: Colors.orange.withValues(alpha: 0.1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  text['failed_desc']!,
                                  style: GoogleFonts.inter(fontSize: 14, height: 1.5, color: isDark ? Colors.grey[300] : Colors.black87),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.info_outline, size: 14, color: Colors.orange),
                                    const SizedBox(width: 6),
                                    Text(
                                      text['failed_info']!,
                                      style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.orange),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Helpdesk Section
                          _buildSectionHeader(Icons.support_agent, text['helpdesk_title']!),
                          const SizedBox(height: 12),
                          _buildContactLink(Icons.mail, text['email_support']!, 'infoceloe@telkomuniversity.ac.id', 
                            Colors.pink, _launchEmail),
                          const SizedBox(height: 12),
                          _buildContactLink(Icons.chat, text['wa_support']!, '+62 821-1666-3563', 
                            Colors.green, _launchWhatsApp),
                          
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

  Widget _buildLanguageButton(String code, String flag) {
    bool isSelected = _language == code;
    return GestureDetector(
      onTap: () => setState(() => _language = code),
      behavior: HitTestBehavior.opaque,
      child: Opacity(
        opacity: isSelected ? 1.0 : 0.6,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.grey.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                boxShadow: isSelected ? [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4))
                ] : [],
                border: Border.all(
                  color: isSelected ? const Color(0xFFc026d3) : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Text(flag, style: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 8),
            Text(
              code,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? const Color(0xFFc026d3) : Colors.grey,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 4, 
              width: isSelected ? 16 : 0, 
              margin: const EdgeInsets.only(top: 4), 
              decoration: BoxDecoration(
                color: const Color(0xFFc026d3), 
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title, {Color iconColor = const Color(0xFFc026d3)}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            color: iconColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required Widget child, required Color color, required Color borderColor}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: child,
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String desc, {String? code}) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1e293b) : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[100]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey[400], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label.toUpperCase(), style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                const SizedBox(height: 4),
                Text(desc, style: GoogleFonts.inter(fontSize: 13, color: isDark ? Colors.grey[300] : Colors.black87)),
                if (code != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black.withValues(alpha: 0.3) : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[200]!),
                    ),
                    child: Text(code, style: GoogleFonts.firaCode(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFFc026d3))),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactLink(IconData icon, String title, String value, Color iconColor, VoidCallback onTap) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1e293b) : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.transparent),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5)],
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.inter(fontSize: 11, color: Colors.grey)),
                  Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black87), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
