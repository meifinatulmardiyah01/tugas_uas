import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_saya/screens/quiz_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailScreen({super.key, required this.course});

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
      body: CustomScrollView(
        slivers: [
          // Elegant Hero Header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            elevation: 0,
            backgroundColor: const Color(0xFF8B5CF6),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(gradient: primaryGradient),
                child: Stack(
                  children: [
                    Positioned(
                      top: -50,
                      right: -30,
                      child: Icon(
                        _getIconData(course['icon']),
                        size: 200,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              course['code'],
                              style: GoogleFonts.poppins(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            course['title'],
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
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
                  // Instructor Card
                  _buildInstructorCard(isDark),
                  const SizedBox(height: 24),

                  // Progress Section
                  _buildSectionTitle('Progres Belajar', isDark),
                  const SizedBox(height: 16),
                  _buildProgressSection(isDark),
                  const SizedBox(height: 32),

                  // Description
                  _buildSectionTitle('Tentang Mata Kuliah', isDark),
                  const SizedBox(height: 12),
                  Text(
                    course['description'],
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Modules List
                  _buildSectionTitle('Materi Pembelajaran', isDark),
                  const SizedBox(height: 16),
                  ...List.generate(
                    (course['modules'] as List).length,
                    (index) => _buildModuleTile(course['modules'][index], isDark, context),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructorCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1F2937) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
            child: const Icon(Icons.person, color: Color(0xFF8B5CF6)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dosen Pengampu',
                  style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey),
                ),
                Text(
                  course['instructor'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
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

  Widget _buildProgressSection(bool isDark) {
    double progress = course['progress'];
    int percentage = (progress * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1F2937) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$percentage% Selesai',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFEC4899),
                ),
              ),
              Text(
                '${(course['modules'] as List).where((m) => m['completed']).length}/${(course['modules'] as List).length} Modul',
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFEC4899)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleTile(Map<String, dynamic> module, bool isDark, BuildContext context) {
    IconData icon;
    Color iconColor;
    
    switch (module['type']) {
      case 'video':
        icon = Icons.play_circle_fill;
        iconColor = Colors.blue;
        break;
      case 'pdf':
        icon = Icons.description_rounded;
        iconColor = Colors.orange;
        break;
      case 'quiz':
        icon = Icons.assignment_turned_in_rounded;
        iconColor = Colors.green;
        break;
      default:
        icon = Icons.book;
        iconColor = Colors.grey;
    }

    bool completed = module['completed'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          if (module['type'] == 'quiz' && module['questions'] != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizScreen(
                  title: module['title'],
                  questions: List<Map<String, dynamic>>.from(module['questions']),
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Membuka ${module['title']}...')),
            );
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1F2937) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: completed ? const Color(0xFFEC4899).withValues(alpha: 0.2) : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      module['title'],
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    Text(
                      module['duration'],
                      style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              if (completed)
                const Icon(Icons.check_circle, color: Color(0xFFEC4899), size: 20)
              else
                const Icon(Icons.lock_outline, color: Colors.grey, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black87,
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
