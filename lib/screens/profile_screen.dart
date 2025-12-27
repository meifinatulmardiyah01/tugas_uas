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
  int _activeTab = 1; // 0: About Me, 1: Kelas, 2: Edit Profile

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
          // Vibrant Centered Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, bottom: 80, left: 24, right: 24),
            decoration: BoxDecoration(
              gradient: primaryGradient,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: ClipOval(
                    child: Image.network(_auth.avatarUrl, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _auth.fullName.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tab View Content
          Expanded(
            child: Container(
              transform: Matrix4.translationValues(0, -30, 0),
              child: Column(
                children: [
                  // Tab Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1F2937) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          _buildTabItem(0, 'About Me', isDark),
                          _buildTabItem(1, 'Kelas', isDark),
                          _buildTabItem(2, 'Edit Profile', isDark),
                        ],
                      ),
                    ),
                  ),

                  // Tab Content
                  Expanded(
                    child: _buildActiveTabContent(isDark),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String label, bool isDark) {
    bool isActive = _activeTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = index),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  color: isActive 
                      ? (isDark ? Colors.white : Colors.black)
                      : Colors.grey,
                ),
              ),
            ),
            if (isActive)
              Container(
                width: 30,
                height: 3,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  borderRadius: BorderRadius.circular(10),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildActiveTabContent(bool isDark) {
    switch (_activeTab) {
      case 0: return _buildAboutTab(isDark);
      case 1: return _buildKelasTab(isDark);
      case 2: return _buildEditTab(isDark);
      default: return const SizedBox();
    }
  }

  Widget _buildAboutTab(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoSection('Informasi Akun', [
            _buildInfoRow(Icons.person_outline, 'Nama Lengkap', _auth.fullName, isDark),
            _buildInfoRow(Icons.badge_outlined, 'NIM/Username', _auth.currentUsername, isDark),
            _buildInfoRow(Icons.email_outlined, 'Email', _auth.email, isDark),
          ], isDark),
          const SizedBox(height: 24),
          _buildInfoSection('Akademik', [
            _buildInfoRow(Icons.school_outlined, 'Program Studi', _auth.prodi, isDark),
            _buildInfoRow(Icons.account_balance_outlined, 'Fakultas', _auth.fakultas, isDark),
            _buildInfoRow(Icons.public_outlined, 'Negara', _auth.country, isDark),
          ], isDark),
          const SizedBox(height: 24),
          _buildInfoSection('Akses Terakhir', [
            _buildInfoRow(Icons.login, 'First access', 'Monday, 8 February 2021', isDark),
            _buildInfoRow(Icons.access_time, 'Last access', _currentTime, isDark),
          ], isDark),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false),
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Log Out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[50],
                foregroundColor: Colors.red,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKelasTab(bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 100),
      itemCount: _auth.courses.length,
      itemBuilder: (context, index) {
        final course = _auth.courses[index];
        return _buildCourseCard(course, isDark);
      },
    );
  }

  Widget _buildEditTab(bool isDark) {
    return _ProfileEditForm(
      auth: _auth, 
      onSave: () => setState(() => _activeTab = 0),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF8B5CF6),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1F2937) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 5,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey)),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course, bool isDark) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CourseDetailScreen(course: course)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1F2937) : Colors.white,
          borderRadius: BorderRadius.circular(16),
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
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Color(course['color']),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getIconData(course['icon']),
                color: Color(course['iconColor']),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course['title'].toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course['code'],
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: const Color(0xFFEC4899),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
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
}

class _ProfileEditForm extends StatefulWidget {
  final AuthService auth;
  final VoidCallback onSave;

  const _ProfileEditForm({required this.auth, required this.onSave});

  @override
  State<_ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<_ProfileEditForm> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _countryController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.auth.firstName);
    _lastNameController = TextEditingController(text: widget.auth.lastName);
    _emailController = TextEditingController(text: widget.auth.email);
    _countryController = TextEditingController(text: widget.auth.country);
    _descriptionController = TextEditingController(text: widget.auth.description);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _countryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 120),
      child: Column(
        children: [
          _buildTextField('Nama Pertama', _firstNameController, isDark, placeholder: 'Enter first name'),
          _buildTextField('Nama Terakhir', _lastNameController, isDark, placeholder: 'Enter last name'),
          _buildTextField('E-mail Address', _emailController, isDark, placeholder: 'name@example.com', keyboardType: TextInputType.emailAddress),
          _buildTextField('Negara', _countryController, isDark, placeholder: 'Indonesia'),
          _buildTextField('Deskripsi', _descriptionController, isDark, placeholder: 'Write something about yourself...', maxLines: 4),
          
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.auth.updateProfile(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    email: _emailController.text,
                    country: _countryController.text,
                    description: _descriptionController.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profil berhasil disimpan!')),
                  );
                  widget.onSave();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
                  foregroundColor: isDark ? Colors.white : Colors.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: Text('Simpan', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, bool isDark, {String? placeholder, int maxLines = 1, TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.grey[300] : Colors.grey[800],
              ),
            ),
          ),
          TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: GoogleFonts.poppins(fontSize: 14, color: isDark ? Colors.white : Colors.black87),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
              filled: true,
              fillColor: isDark ? const Color(0xFF1F2937) : Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[400]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xFF8B5CF6), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
