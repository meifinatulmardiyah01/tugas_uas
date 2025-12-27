import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_saya/services/auth_service.dart';
import 'package:uas_saya/screens/course_detail_screen.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = AuthService();
  final String _currentTime = DateFormat('EEEE, d MMMM yyyy, h:mm a').format(DateTime.now());
  int _activeTab = 1; // Default to "Kelas" as per HTML screenshot

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryGradient = const LinearGradient(
      colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF111827) : const Color(0xFFF3F4F6),
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, bottom: 60),
            decoration: BoxDecoration(
              gradient: primaryGradient,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                // Profile Image
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(_auth.avatarUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Name
                Text(
                  _auth.fullName.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tab Section
          Transform.translate(
            offset: const Offset(0, -25),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1F2937) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? Colors.grey[700]! : Colors.grey[100]!,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    _buildTabItem(0, 'About Me'),
                    _buildTabItem(1, 'Kelas'),
                    _buildTabItem(2, 'Edit Profile'),
                  ],
                ),
              ),
            ),
          ),

          // Content Section
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
              child: _buildContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String label) {
    bool isActive = _activeTab == index;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor = const Color(0xFFC026D3);

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: isActive 
              ? Border(bottom: BorderSide(color: activeColor, width: 2))
              : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive 
                ? activeColor
                : (isDark ? Colors.grey[400] : Colors.grey[500]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_activeTab == 0) return _buildAboutMe();
    if (_activeTab == 1) return _buildKelas();
    if (_activeTab == 2) return _buildEditProfile();
    return const SizedBox();
  }

  Widget _buildAboutMe() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildSectionTitle('Informasi User'),
        const SizedBox(height: 16),
        _buildInfoItem('Email address', _auth.currentUsername),
        const SizedBox(height: 16),
        _buildInfoItem('Program Studi', _auth.prodi),
        const SizedBox(height: 16),
        _buildInfoItem('Fakultas', _auth.fakultas),
        
        const SizedBox(height: 32),
        
        _buildSectionTitle('Aktivitas Login'),
        const SizedBox(height: 16),
        _buildInfoItem('First access to site', 'Monday, 7 September 2020, 9:27 AM', subText: '(Historical)'),
        const SizedBox(height: 16),
        _buildInfoItem('Last access to site', _currentTime, subText: '(now)'),
        
        const SizedBox(height: 32),
        
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
            icon: const Icon(Icons.logout, size: 18),
            label: const Text('Log Out'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC026D3),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKelas() {
    return Column(
      children: [
        const SizedBox(height: 8),
        ..._auth.courses.map((course) => _buildCourseCard(course)),
      ],
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailScreen(course: course),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1F2937) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.grey[700]! : const Color(0xFFF9FAFB),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Color(course['color']),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _getIconData(course['icon']),
                color: Color(course['iconColor']),
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    course['title'].toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    course['code'],
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFC026D3),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.event, size: 10, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        course['date'],
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          color: Colors.grey,
                        ),
                      ),
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

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'language': return Icons.language;
      case 'design_services': return Icons.design_services;
      case 'public': return Icons.public;
      case 'sports_soccer': return Icons.sports_soccer;
      case 'code': return Icons.code;
      case 'smartphone': return Icons.smartphone;
      case 'settings_system_daydream': return Icons.settings_system_daydream;
      default: return Icons.school;
    }
  }

  Widget _buildEditProfile() {
    return Column(
      children: [
        const SizedBox(height: 24),
        _ProfileEditForm(onSaved: () => setState(() => _activeTab = 0)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black87,
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, {String? subText}) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.grey[200] : Colors.grey[800],
                ),
              ),
              if (subText != null)
                TextSpan(
                  text: ' $subText',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[500],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileEditForm extends StatefulWidget {
  final VoidCallback onSaved;
  const _ProfileEditForm({required this.onSaved});

  @override
  State<_ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<_ProfileEditForm> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _prodiController;
  late TextEditingController _fakultasController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _auth.fullName);
    _prodiController = TextEditingController(text: _auth.prodi);
    _fakultasController = TextEditingController(text: _auth.fakultas);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField('Nama Lengkap', _nameController),
          const SizedBox(height: 16),
          _buildTextField('Program Studi', _prodiController),
          const SizedBox(height: 16),
          _buildTextField('Fakultas', _fakultasController),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _auth.updateProfile(
                    fullName: _nameController.text,
                    prodi: _prodiController.text,
                    fakultas: _fakultasController.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profil berhasil diperbarui!')),
                  );
                  widget.onSaved();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC026D3),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Simpan Perubahan'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.grey),
        filled: true,
        fillColor: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      validator: (v) => v!.isEmpty ? 'Tidak boleh kosong' : null,
    );
  }
}
