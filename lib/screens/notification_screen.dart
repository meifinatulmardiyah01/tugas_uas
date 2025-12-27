import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:uas_saya/services/auth_service.dart';
import 'package:uas_saya/screens/quiz_screen.dart';
import 'package:uas_saya/screens/course_detail_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final notifications = _auth.notifications;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF111827) : const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1F2937) : Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Notifikasi',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: isDark ? Colors.white : Colors.black87, size: 20),
          onPressed: () {
            // Usually would go back, but in bottom nav this might just stay or close
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: notifications.length + 1,
        itemBuilder: (context, index) {
          if (index == notifications.length) return const SizedBox(height: 100);

          final item = notifications[index];
          
          if (item['isOldSection'] == true && index > 0 && notifications[index-1]['isOldSection'] != true) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 12, left: 8),
                  child: Text(
                    'MINGGU LALU',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 1.2,
                    ),
                  ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1, end: 0),
                ),
                _buildNotificationCard(item, isDark, index),
              ],
            );
          }

          return _buildNotificationCard(item, isDark, index);
        },
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> item, bool isDark, int index) {
    IconData icon;
    Color iconBg;
    Color iconColor;

    switch (item['type']) {
      case 'quiz':
        icon = Icons.quiz_rounded;
        iconBg = Colors.purple.withValues(alpha: 0.1);
        iconColor = Colors.purple;
        break;
      case 'check_circle':
        icon = Icons.check_circle_rounded;
        iconBg = Colors.green.withValues(alpha: 0.1);
        iconColor = Colors.green;
        break;
      default:
        icon = Icons.description_rounded;
        iconBg = Colors.blue.withValues(alpha: 0.1);
        iconColor = Colors.blue;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          final courseIndex = item['courseIndex'];
          final course = _auth.courses[courseIndex];
          
          _auth.markNotificationAsRead(index);
          setState(() {}); 

          if (item['type'] == 'quiz') {
            final quizModule = (course['modules'] as List).firstWhere(
              (m) => m['type'] == 'quiz' && (m['title'] == item['highlight'] || item['message'].contains(m['title'])),
              orElse: () => null,
            );

            if (quizModule != null && quizModule['questions'] != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(
                    title: quizModule['title'],
                    questions: List<Map<String, dynamic>>.from(quizModule['questions']),
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CourseDetailScreen(course: course)),
              );
            }
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CourseDetailScreen(course: course)),
            );
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1F2937) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: item['isNew'] 
                  ? const Color(0xFF8B5CF6).withValues(alpha: 0.3)
                  : (isDark ? Colors.grey[800]! : Colors.grey[200]!),
              width: item['isNew'] ? 1.5 : 1.0,
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ).animate(onPlay: (c) => c.repeat(reverse: true))
                .shimmer(duration: 2.seconds, color: Colors.white24)
                .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 2.seconds, curve: Curves.easeInOut),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRichMessage(item['message'], item['highlight'], isDark),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.schedule_rounded, size: 12, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          item['time'],
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (item['isNew'])
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEC4899), // Pink dot
                    shape: BoxShape.circle,
                  ),
                ).animate(onPlay: (c) => c.repeat())
                 .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2), duration: 800.ms, curve: Curves.easeInOut)
                 .then()
                 .scale(begin: const Offset(1.2, 1.2), end: const Offset(0.8, 0.8), duration: 800.ms),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildRichMessage(String message, String? highlight, bool isDark) {
    if (highlight == null || !message.contains(highlight)) {
      return Text(
        message,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : Colors.black87,
        ),
      );
    }

    final parts = message.split(highlight);
    return RichText(
      text: TextSpan(
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : Colors.black87,
        ),
        children: [
          TextSpan(text: parts[0]),
          TextSpan(
            text: highlight,
            style: const TextStyle(
              color: Color(0xFF8B5CF6), // Fuchsia/Violet highlight
              fontWeight: FontWeight.bold,
            ),
          ),
          if (parts.length > 1) TextSpan(text: parts[1]),
        ],
      ),
    );
  }
}
