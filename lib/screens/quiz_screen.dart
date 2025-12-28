import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizScreen extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> questions;

  const QuizScreen({super.key, required this.title, required this.questions});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Theme Colors from HTML
  final Color primaryColor = const Color(0xFFDB2777); // Pink 600
  final Color primaryDark = const Color(0xFFBE185D); // Pink 700
  final Color backgroundLight = const Color(0xFFF3F4F6); // Gray 100
  final Color backgroundDark = const Color(0xFF111827); // Gray 900
  final Color surfaceLight = Colors.white;
  final Color surfaceDark = const Color(0xFF1F2937); // Gray 800

  int _currentIndex = 0;
  // Store selected answer for each question index
  final Map<int, int> _selectedAnswers = {}; 
  
  // Timer
  Timer? _timer;
  int _remainingSeconds = 900; // 15:00 minutes

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer?.cancel();
          _finishQuiz();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }

  void _selectOption(int index) {
    setState(() {
      _selectedAnswers[_currentIndex] = index;
    });
  }

  void _nextQuestion() {
    if (_currentIndex < widget.questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      _finishQuiz();
    }
  }

  void _jumpToQuestion(int index) {
    // Only allow jumping if the index is within range. 
    // In a real app we might restricting jumping ahead, but HTML UI shows full grid.
    if (index < widget.questions.length) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _finishQuiz() {
    // Calculate Score
    int score = 0;
    for (int i = 0; i < widget.questions.length; i++) {
        if (_selectedAnswers[i] == widget.questions[i]['correctAnswer']) {
            score++;
        }
    }
    
    // Show Result Dialog or Navigate
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Quiz Completed'),
        content: Text('Your score: $score / ${widget.questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // Close Dialog
              Navigator.pop(context); // Close Quiz Screen
            },
            child: const Text('Finish'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final currentQuestion = widget.questions[_currentIndex];
    
    return Scaffold(
      backgroundColor: isDark ? backgroundDark : backgroundLight,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
             color: isDark ? const Color(0xFF000000) : Colors.white, // Inner container bg like HTML
             borderRadius: BorderRadius.circular(24),
             boxShadow: [
               BoxShadow(
                 color: Colors.black.withOpacity(0.2),
                 blurRadius: 20,
                 offset: const Offset(0, 10),
               )
             ]
          ),
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0), // Full screen in mobile usually, adapted from HTML layout
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.only(top: 24, bottom: 24, left: 24, right: 24),
                color: primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.timer, color: Colors.white, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            _formatTime(_remainingSeconds),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFeatures: [const FontFeature.tabularFigures()],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    // Question Grid
                    Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            alignment: WrapAlignment.center,
                            children: List.generate(
                                // Use provided question count or default to 15 bubbles as per HTML design if fewer questions
                                // But logicaly should match questions length. HTML shows 15.
                                widget.questions.length > 15 ? widget.questions.length : 15,
                                (index) => _buildGridNumber(index, isDark)
                            ),
                        ),
                    ),
                    
                    // Question Section
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Soal Nomor ${_currentIndex + 1} / ${widget.questions.length}',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.grey[900],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            currentQuestion['text'],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF374151),
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Options
                    Column(
                        children: List.generate(
                            (currentQuestion['options'] as List).length,
                            (index) => _buildOption(index, currentQuestion['options'][index], isDark),
                        ),
                    ),
                    
                    const SizedBox(height: 32),

                    // Next Button
                    Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                            onPressed: _nextQuestion,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
                                foregroundColor: isDark ? Colors.white : const Color(0xFF1F2937),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 0,
                            ),
                            child: Text(
                                _currentIndex == widget.questions.length - 1 ? 'Selesai' : 'Soal Selanjutnya',
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                            ),
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridNumber(int index, bool isDark) {
    bool isCurrent = index == _currentIndex;
    // Check if this index exists in questions
    bool isActive = index < widget.questions.length;
    bool isAnswered = isActive && _selectedAnswers.containsKey(index);
    
    // Default appearance for inactive mock bubbles (if any)
    Color bgColor = isDark ? Colors.transparent : Colors.transparent;
    Color textColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    Color borderColor = isDark ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB);

    if (isActive) {
        if (isCurrent) {
            bgColor = primaryColor;
            textColor = Colors.white;
            borderColor = primaryColor;
        } else if (isAnswered) {
             // Maybe Green to show answered? HTML just shows one active.
             // I'll stick to simple outline for non-current, but maybe filled if answered?
             // HTML shows button 1 active (Pink filled), others outline.
             bgColor = Colors.transparent;
             textColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
             borderColor = isDark ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB);
        }
    } else {
        // Disabled style
    }

    return GestureDetector(
      onTap: isActive ? () => _jumpToQuestion(index) : null,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
           color: bgColor,
           shape: BoxShape.circle,
           border: Border.all(color: borderColor, width: isCurrent ? 0 : 1.5),
           boxShadow: isCurrent ? [
               BoxShadow(
                   color: primaryColor.withOpacity(0.4),
                   blurRadius: 6,
                   offset: const Offset(0, 2),
               )
           ] : [],
        ),
        alignment: Alignment.center,
        child: Text(
           '${index + 1}',
           style: GoogleFonts.poppins(
               fontSize: 12,
               fontWeight: FontWeight.bold,
               color: textColor,
           ),
        ),
      ),
    );
  }

  Widget _buildOption(int index, String text, bool isDark) {
      int? selected = _selectedAnswers[_currentIndex];
      bool isSelected = selected == index;
      
      return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GestureDetector(
              onTap: () => _selectOption(index),
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: isSelected ? primaryColor : (isDark ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6)),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isSelected ? [
                          BoxShadow(
                              color: primaryColor.withOpacity(0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                          )
                      ] : [],
                  ),
                  child: Row(
                      children: [
                          Text(
                              String.fromCharCode(65 + index) + '.',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
                              ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                              child: Text(
                                  text,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected ? Colors.white : (isDark ? Colors.white : const Color(0xFF1F2937)),
                                  ),
                              ),
                          ),
                      ],
                  ),
              ),
          ),
      );
  }
}
