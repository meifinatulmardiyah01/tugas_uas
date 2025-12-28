import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_saya/screens/material_content_screen.dart';
import 'package:uas_saya/screens/quiz_screen.dart';

class CourseMaterialScreen extends StatefulWidget {
  final Map<String, dynamic> course;

  const CourseMaterialScreen({super.key, required this.course});

  @override
  State<CourseMaterialScreen> createState() => _CourseMaterialScreenState();
}

class _CourseMaterialScreenState extends State<CourseMaterialScreen> {
  int _activeTab = 0; // 0 for Materi, 1 for Tugas Dan Kuis

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final meetings = widget.course['meetings'] as List<dynamic>? ?? [];

    final brandGradient = const LinearGradient(
      colors: [Color(0xFF9C27B0), Color(0xFFE91E63)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF2F2F2),
      body: Column(
        children: [
          // Header - Match HTML strictly
          Container(
            padding: const EdgeInsets.fromLTRB(16, 60, 16, 40),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: brandGradient,
              boxShadow: isDark ? [] : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.only(top: 2),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DESAIN ANTARMUKA & PENGALAMAN',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'PENGGUNA ${widget.course['code']}',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Tabs Card - Overlapping effect
          Transform.translate(
            offset: const Offset(0, -24),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _activeTab = 0),
                        child: Container(
                          color: Colors.transparent,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                'Materi',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : const Color(0xFF111827),
                                ),
                              ),
                              if (_activeTab == 0)
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: 48,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF1F2937),
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _activeTab = 1),
                        child: Container(
                          color: Colors.transparent,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                'Tugas Dan Kuis',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: _activeTab == 1 ? FontWeight.bold : FontWeight.w500,
                                  color: _activeTab == 1 
                                      ? (isDark ? Colors.white : const Color(0xFF111827))
                                      : const Color(0xFF6B7280),
                                ),
                              ),
                              if (_activeTab == 1)
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: 100,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF1F2937),
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Main Content
          Expanded(
            child: _activeTab == 0 
              ? ListView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                  children: [
                    _buildMaterialCategoryCard(
                      'Frontend Development', 
                      'React, Vue, Flutter, and UI/UX design', 
                      Icons.web_rounded, 
                      Colors.blue, 
                      isDark,
                      [
                        {'title': 'Introduction to React', 'type': 'video', 'duration': '15:00'},
                        {'title': 'Flutter Layout Basics', 'type': 'pdf', 'duration': '2.1 MB'},
                        {'title': 'State Management in Flutter', 'type': 'video', 'duration': '25:40'},
                      ],
                    ),
                    _buildMaterialCategoryCard(
                      'Backend Development', 
                      'Node.js, Python, Databases, and API', 
                      Icons.storage_rounded, 
                      Colors.green, 
                      isDark,
                      [
                        {'title': 'Node.js and Express Setup', 'type': 'video', 'duration': '12:30'},
                        {'title': 'Designing Relational Databases', 'type': 'pdf', 'duration': '3.5 MB'},
                        {'title': 'REST API Best Practices', 'type': 'video', 'duration': '20:15'},
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'PERTEMUAN KULIAH',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...meetings.map((meeting) => _buildMeetingCard(meeting, isDark)),
                  ],
                )
              : ListView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                  children: _getAssignments().map((item) => _buildAssignmentCard(item, isDark)).toList(),
                ),
          ),
        ],
      ),
      // Custom Bottom Navigation to match HTML
      bottomNavigationBar: _buildBottomNav(isDark, context),
    );
  }

  Widget _buildMeetingCard(dynamic meeting, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.transparent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF5D9CEC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  meeting['meetingNumber'].toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Icon(
                meeting['isCompleted'] 
                    ? Icons.check_circle_rounded 
                    : Icons.radio_button_checked_rounded,
                color: meeting['isCompleted'] ? const Color(0xFF22C55E) : Colors.grey[400],
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            meeting['title'],
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            meeting['summary'],
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(bool isDark, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF9C27B0), Color(0xFFE91E63)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_rounded, 'Home', false, context),
              _buildNavItem(Icons.school_rounded, 'Kelas Saya', true, context),
              _buildNavItem(Icons.notifications_rounded, 'Notifikasi', false, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialCategoryCard(String title, String desc, IconData icon, Color color, bool isDark, List<Map<String, dynamic>> materials) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MaterialContentScreen(
              categoryTitle: title,
              materials: materials,
              themeColor: color,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
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
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    desc,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: color.withValues(alpha: 0.5)),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getAssignments() {
    return [
      {
        'type': 'Quiz',
        'title': 'Quiz Review 01',
        'deadline': '25 Februari 2021 23:59 WIB',
        'status': 'completed',
        'icon': Icons.quiz_rounded,
        'questions': [
          {'text': 'Prinsip utama UI Design adalah?', 'options': ['Estetika', 'Kegunaan', 'Warna', 'Animasi'], 'correctAnswer': 1},
          {'text': 'Apa kepanjangan dari UI?', 'options': ['User Interest', 'User Interface', 'User Industry', 'User Information'], 'correctAnswer': 1},
        ]
      },
      {
        'type': 'Tugas',
        'title': 'Tugas 01 - UID Android Mobile Game',
        'deadline': '25 Februari 2021 23:59 WIB',
        'status': 'unverified',
        'icon': Icons.assignment_rounded,
      },
      {
        'type': 'Pertemuan 3',
        'title': 'Kuis - Assessment 2',
        'deadline': '28 Februari 2021 23:59 WIB',
        'status': 'completed',
        'icon': Icons.quiz_rounded,
        'questions': [
          {'text': 'Apa itu UX?', 'options': ['User Experience', 'User Experiment', 'User X-factor', 'User Example'], 'correctAnswer': 0},
          {'text': 'Manakah tool yang populer untuk UI/UX?', 'options': ['Excel', 'Figma', 'Word', 'PowerPoint'], 'correctAnswer': 1},
        ]
      },
    ];
  }

  Widget _buildAssignmentCard(Map<String, dynamic> item, bool isDark) {
    bool isQuiz = item['type'].toString().toLowerCase().contains('quiz') || item['type'].toString().toLowerCase().contains('kuis');
    bool isCompleted = item['status'] == 'completed';

    return GestureDetector(
      onTap: () {
        if (isQuiz && item['questions'] != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizScreen(
                title: item['title'],
                questions: List<Map<String, dynamic>>.from(item['questions']),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Membuka ${item['title']}...'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: const Color(0xFFE91E63),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isDark ? Colors.grey[800]! : Colors.grey[100]!,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE91E63), // Pink badge
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item['type'].toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Icon(
                  isCompleted ? Icons.check_circle : Icons.verified_user,
                  color: isCompleted ? const Color(0xFF10B981) : Colors.grey[300],
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2D2D2D) : const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item['icon'],
                    size: 28,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item['title'],
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Text(
              'Tenggat Waktu : ${item['deadline']}',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
