import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_saya/screens/question_review_screen.dart';

class QuizReviewScreen extends StatelessWidget {
  final List<Map<String, dynamic>> questions;
  final Map<int, int> userAnswers;
  final int timeTakenSeconds; // Mock or passed from quiz

  const QuizReviewScreen({
    super.key, 
    required this.questions, 
    required this.userAnswers,
    this.timeTakenSeconds = 802, // Mock: 13 mins 22 sec
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Theme Colors
    final Color primaryColor = const Color(0xFF9333EA); // Purple-600
    final Color secondaryColor = const Color(0xFFDB2777); // Pink-600
    final Color backgroundLight = Colors.white;
    final Color backgroundDark = const Color(0xFF111827);
    final Color surfaceLight = const Color(0xFFF3F4F6);
    final Color surfaceDark = const Color(0xFF1F2937);

    return Scaffold(
      backgroundColor: isDark ? backgroundDark : backgroundLight,
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            color: primaryColor,
            alignment: Alignment.center,
            child: Text(
              'Review Jawaban',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Summary Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? surfaceDark : surfaceLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[200]!),
                  ),
                  child: Column(
                    children: [
                      _buildSummaryRow('Di Mulai Pada', 'Kamis 25 Februari 2021 10:25', isDark),
                      const SizedBox(height: 8),
                      _buildSummaryRow('Status', 'Selesai', isDark),
                      const SizedBox(height: 8),
                      _buildSummaryRow('Selesai Pada', 'Kamis 25 Februari 2021 10:48', isDark),
                      const SizedBox(height: 8),
                      _buildSummaryRow('Waktu Penyelesaian', '13 Menit 22 Detik', isDark),
                      const SizedBox(height: 8),
                      _buildSummaryRow('Nilai', '0 / 100', isDark), // Mock score usually calculated before or here
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Questions List
                ...List.generate(questions.length, (index) {
                  final question = questions[index];
                  final userAnswerIndex = userAnswers[index];
                  String answerText = '-';
                  if (userAnswerIndex != null) {
                    List options = question['options'];
                    if (userAnswerIndex < options.length) {
                         String letter = String.fromCharCode(65 + userAnswerIndex);
                         answerText = '$letter. ${options[userAnswerIndex]}';
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 80,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              'Pertanyaan ${index + 1}',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.grey[200] : Colors.grey[800],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isDark ? Colors.grey[700] : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  question['text'],
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    height: 1.5,
                                    color: isDark ? Colors.grey[100] : Colors.grey[800],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Jawaban Tersimpan',
                                          style: GoogleFonts.inter(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: isDark ? Colors.grey[400] : Colors.grey[500],
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          answerText,
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: isDark ? Colors.white : Colors.grey[900],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                       Navigator.push(
                                         context,
                                         MaterialPageRoute(
                                           builder: (context) => QuestionReviewScreen(
                                             initialIndex: index,
                                             questions: questions,
                                             userAnswers: userAnswers,
                                           ),
                                         ),
                                       );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Text(
                                        'Lihat Soal',
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[600],
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                
                const SizedBox(height: 24),
                
                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate back to Overview or Course
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 8,
                      shadowColor: secondaryColor.withOpacity(0.4),
                    ),
                    child: Text(
                      'Kirim Jawaban',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.grey[300] : Colors.grey[700],
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }
}
