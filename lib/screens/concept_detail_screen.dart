import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_saya/screens/quiz_screen.dart';
import 'package:uas_saya/screens/assignment_detail_screen.dart';

class ConceptDetailScreen extends StatefulWidget {
  const ConceptDetailScreen({super.key});

  @override
  State<ConceptDetailScreen> createState() => _ConceptDetailScreenState();
}

class _ConceptDetailScreenState extends State<ConceptDetailScreen> {
  int _activeTab = 0; // 0 = Lampiran Materi, 1 = Tugas dan Kuis
  final Color primaryColor = const Color(0xFF8B5CF6); // Purple as requested
  final Color secondaryColor = const Color(0xFFEC4899); // Pink as requested
  final Color successColor = const Color(0xFF10B981); // Green

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF111827) : const Color(0xFFF3F4F6),
      body: SafeArea(
        child: Column(
          children: [
            // Handle bar
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 12, bottom: 4),
              child: Container(
                width: 48,
                height: 6,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[600] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            
            // Header Part
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                children: [
                  Text(
                    'Konsep User Interface Design',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Deskripsi',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Konsep dasar User Interface Design akan dipelajari bagaimana membangun sebuah Interaction Design pada antarmuka. Interaction ini sangat penting untuk aplikasi berkomunikasi dengan pengguna. Lalu dipelajari juga poin-poin penting pada interaction design seperti visibility, feedback, limitation, consistency dan affordance. Dan terakhir materi conceptual dan perceptual design interaction akan memberikan gambaran bagaimana bentuk dari interaction.',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      height: 1.6,
                      color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),

            // Tab Bar
            Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1F2937).withOpacity(0.5) : const Color(0xFFF9FAFB),
                border: Border(bottom: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[200]!)),
              ),
              child: Row(
                children: [
                  _buildTabItem('Lampiran Materi', 0, isDark),
                  _buildTabItem('Tugas dan Kuis', 1, isDark),
                ],
              ),
            ),

            // Tab Content
            Expanded(
              child: Container(
                 color: isDark ? const Color(0xFF111827) : const Color(0xFFF3F4F6),
                 child: _activeTab == 0 ? _buildMaterialList(isDark) : _buildTaskList(isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String label, int index, bool isDark) {
    bool isActive = _activeTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          color: Colors.transparent,
          child: Column(
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  color: isActive 
                      ? (isDark ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937)) 
                      : (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
                ),
              ),
              if (isActive)
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 64,
                  height: 4,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMaterialList(bool isDark) {
    final List<Map<String, dynamic>> items = [
      {'title': 'Zoom Meeting Synchronous', 'icon': Icons.link, 'completed': true},
      {'title': 'Elemen-elemen Antarmuka Pengguna', 'icon': Icons.description_outlined, 'completed': true},
      {'title': 'UID Guidelines and Principles', 'icon': Icons.menu_book, 'completed': true},
      {'title': 'User Profile', 'icon': Icons.account_circle, 'completed': true},
      {'title': 'Principles of UI Design/URL', 'icon': Icons.link, 'completed': true},
      {'title': 'Interaction Design Video', 'icon': Icons.movie, 'completed': false},
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: items.length + 1, // +1 for spacing
      itemBuilder: (context, index) {
        if (index == items.length) return const SizedBox(height: 80);
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Membuka ${item['title']}...')),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1F2937) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[200]!),
                boxShadow: isDark ? [] : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item['icon'] as IconData, color: primaryColor, size: 20),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      item['title'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937),
                      ),
                    ),
                  ),
                  Icon(
                    item['completed'] ? Icons.check_circle : Icons.settings_rounded,
                    color: item['completed'] ? successColor : Colors.grey[300],
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTaskList(bool isDark) {
     return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildTaskCard(
          isDark: isDark,
          type: 'Quiz',
          title: 'Quiz Review 01',
          description: 'Silahkan kerjakan kuis ini dalam waktu 15 menit sebagai nilai pertama komponen kuis. Jangan lupa klik tombol Submit Answer setelah menjawab seluruh pertanyaan.',
          deadline: 'Kerjakan sebelum hari Jum\'at, 26 Februari 2021 Jam 23:59 WIB.',
          isCompleted: true,
          icon: Icons.quiz_rounded,
          iconColor: primaryColor,
          onTap: () {
             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QuizScreen(
                  title: 'Quiz Review 01',
                  questions: [
                    {'text': 'Prinsip utama UI Design adalah?', 'options': ['Estetika', 'Kegunaan', 'Warna', 'Animasi'], 'correctAnswer': 1},
                    {'text': 'Apa kepanjangan dari UI?', 'options': ['User Interest', 'User Interface', 'User Industry', 'User Information'], 'correctAnswer': 1},
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        _buildTaskCard(
          isDark: isDark,
          type: 'Tugas',
          title: 'Tugas 01 - UID Android Moblie Game',
          description: '1. Buatlah desain tampilan (antarmuka) pada aplikasi mobile game FPS (First Person Shooter) yang akan menjadi tugas pada mata kuliah Pemrograman Aplikasi Permainan.\n2. Desain yang dibuat harus melingkupi seluruh tampilan pada aplikasi/game, dari pertama kali aplikasi ...',
          deadline: '', 
          isCompleted: true, // As shown in HTML checkmark
          icon: Icons.description,
          iconColor: secondaryColor,
          onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AssignmentDetailScreen()),
            );
          },
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _buildTaskCard({
    required bool isDark,
    required String type,
    required String title,
    required String description,
    required String deadline,
    required bool isCompleted,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1F2937) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[200]!),
          boxShadow: [
             if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Icon Section
                  Container(
                    padding: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: isDark ? Colors.grey[600]! : Colors.grey[300]!,
                          style: BorderStyle.solid, 
                        ),
                      ),
                    ),
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Icon(icon, color: iconColor, size: 32),
                      ],
                    ),
                  ),
                  
                  // Content Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 24.0), // Space for checkmark
                          child: Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isDark ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                            height: 1.5,
                          ),
                        ),
                        if (deadline.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            deadline,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              
              // Absolute Checkmark
              Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.check_circle,
                  color: isCompleted ? (type == 'Quiz' ? successColor : (isDark ? Colors.grey[600] : Colors.grey[300])) : Colors.transparent, // Adjusted logic to match HTML visual where Quiz has green check and Task has grey check
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
