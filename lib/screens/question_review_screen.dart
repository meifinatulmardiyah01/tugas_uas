import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionReviewScreen extends StatefulWidget {
  final int initialIndex;
  final List<Map<String, dynamic>> questions;
  final Map<int, int> userAnswers;

  const QuestionReviewScreen({
    super.key,
    required this.initialIndex,
    required this.questions,
    required this.userAnswers,
  });

  @override
  State<QuestionReviewScreen> createState() => _QuestionReviewScreenState();
}

class _QuestionReviewScreenState extends State<QuestionReviewScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _jumpToQuestion(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Map<String, dynamic> question = widget.questions[_currentIndex];
    
    // Theme
    final Color primaryColor = const Color(0xFF8B5CF6); // Purple Header
    final Color selectedColor = const Color(0xFFDB2777); // Pink Selection
    final Color successColor = const Color(0xFF4ADE80); // Green Grid
    final Color backgroundLight = Colors.white;
    final Color backgroundDark = const Color(0xFF18181B);
    final Color cardLight = const Color(0xFFF3F4F6);
    final Color cardDark = const Color(0xFF27272A);

    return Scaffold(
      backgroundColor: isDark ? backgroundDark : backgroundLight,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(top: 50, bottom: 25, left: 24, right: 24),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40), // Spacer for centering
                Text(
                  'Quiz Review 1',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.timer_outlined, color: Colors.white.withOpacity(0.8), size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '15 : 00',
                       style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                // Grid (All Green since reviewed)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    widget.questions.length > 15 ? widget.questions.length : 15,
                    (index) {
                      bool isCurrent = index == _currentIndex;
                      return GestureDetector(
                        onTap: () => _jumpToQuestion(index),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: successColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: isCurrent ? Colors.white : Colors.green[600]!, 
                                width: isCurrent ? 3 : 1
                            ),
                            boxShadow: [
                              if (isCurrent) 
                                BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))
                              else
                                BoxShadow(color: successColor.withOpacity(0.4), blurRadius: 4, offset: const Offset(0, 2))
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${index + 1}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Question Info
                Row(
                  children: [
                    Text(
                      'Soal Nomor ${_currentIndex + 1}',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      ' / ${widget.questions.length}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                Text(
                  question['text'],
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.grey[200] : Colors.grey[900],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Options
                ...List.generate((question['options'] as List).length, (index) {
                   bool isSelected = widget.userAnswers[_currentIndex] == index;
                   
                   return Padding(
                     padding: const EdgeInsets.only(bottom: 12),
                     child: Container(
                       padding: const EdgeInsets.all(16),
                       decoration: BoxDecoration(
                         color: isSelected ? selectedColor : (isDark ? cardDark : cardLight),
                         borderRadius: BorderRadius.circular(12),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.black.withOpacity(0.05),
                             blurRadius: 10,
                             offset: const Offset(0, 4),
                           ),
                         ],
                       ),
                       child: Row(
                         children: [
                           Text(
                             '${String.fromCharCode(65 + index)}.',
                             style: GoogleFonts.poppins(
                               fontSize: 15,
                               fontWeight: FontWeight.bold,
                               color: isSelected ? Colors.white : (isDark ? Colors.grey[300] : Colors.grey[900]),
                             ),
                           ),
                           const SizedBox(width: 16),
                           Expanded(
                             child: Text(
                               question['options'][index],
                               style: GoogleFonts.poppins(
                                 fontSize: 14,
                                 fontWeight: FontWeight.w600,
                                 color: isSelected ? Colors.white : (isDark ? Colors.grey[200] : Colors.grey[800]),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                   );
                }),
                
                const SizedBox(height: 48),
                
                // Back Button
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? cardDark : cardLight,
                      foregroundColor: isDark ? Colors.white : Colors.black,
                      elevation: 4,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(
                      'Kembali Ke Halaman Review',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
