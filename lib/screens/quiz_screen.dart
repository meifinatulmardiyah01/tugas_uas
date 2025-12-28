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
  // Theme Colors (Purple & Pink Combination)
  final Color primaryColor = const Color(0xFF8B5CF6); // Purple 500
  final Color secondaryColor = const Color(0xFFDB2777); // Pink 600
  final Color backgroundLight = const Color(0xFFF8F9FA);
  final Color backgroundDark = const Color(0xFF18181B);
  final Color cardLight = Colors.white;
  final Color cardDark = const Color(0xFF27272A);
  final Color successColor = const Color(0xFF22C55E); // Green

  int _currentIndex = 0;
  final Map<int, int> _selectedAnswers = {}; 
  
  Timer? _timer;
  int _remainingSeconds = 900;

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
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _selectOption(int index) {
    setState(() {
      _selectedAnswers[_currentIndex] = index;
    });
  }

  void _prevQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
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
    if (index < widget.questions.length) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _finishQuiz() {
    int score = 0;
    for (int i = 0; i < widget.questions.length; i++) {
        if (_selectedAnswers[i] == widget.questions[i]['correctAnswer']) {
            score++;
        }
    }
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Quiz Completed'),
        content: Text('Your score: $score / ${widget.questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); 
              Navigator.pop(context); 
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
      body: Column(
        children: [
          // Custom Rounded Header
          Container(
            padding: const EdgeInsets.only(top: 50, bottom: 30, left: 24, right: 24),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 0),
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Quiz Review 1',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.timer_outlined, color: Colors.white, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              _formatTime(_remainingSeconds),
                              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Scrollable Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 100), // Bottom padding for sticky footer
              children: [
                // Number Grid
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    widget.questions.length > 15 ? widget.questions.length : 15,
                    (index) => _buildGridItem(index, isDark),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Question Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Soal Nomor ${_currentIndex + 1}',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.gray[900],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(
                        '/ ${widget.questions.length}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.grey[400] : Colors.grey[500],
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Question Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? cardDark : cardLight,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    currentQuestion['text'],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.grey[200] : const Color(0xFF374151),
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Options
                ...List.generate(
                  (currentQuestion['options'] as List).length,
                  (index) => _buildOptionItem(index, currentQuestion['options'][index], isDark),
                ),
              ],
            ),
          ),
          
          // Sticky Footer
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? cardDark : cardLight,
              border: Border(
                top: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[100]!),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 ElevatedButton(
                   onPressed: _currentIndex > 0 ? _prevQuestion : null,
                   style: ElevatedButton.styleFrom(
                     backgroundColor: isDark ? Colors.grey[800] : const Color(0xFFF3F4F6),
                     foregroundColor: isDark ? Colors.grey[300] : const Color(0xFF4B5563),
                     elevation: 0,
                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                   ),
                   child: Row(
                     children: [
                       Icon(Icons.arrow_back_ios_rounded, size: 14),
                       const SizedBox(width: 8),
                       Text('Soal Sebelumnya', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                     ],
                   ),
                 ),
                 ElevatedButton(
                   onPressed: _nextQuestion,
                   style: ElevatedButton.styleFrom(
                     backgroundColor: isDark ? Colors.grey[800] : const Color(0xFFF3F4F6),
                     foregroundColor: isDark ? Colors.grey[300] : const Color(0xFF4B5563),
                     elevation: 0,
                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                   ),
                   child: Row(
                     children: [
                       Text('Soal Selanjutnya', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                       const SizedBox(width: 8),
                       Icon(Icons.arrow_forward_ios_rounded, size: 14),
                     ],
                   ),
                 ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(int index, bool isDark) {
    final bool isActive = index == _currentIndex;
    final bool isAnswered = index < widget.questions.length && _selectedAnswers.containsKey(index);
    final bool exists = index < widget.questions.length;
    
    // Style Logic
    // 1. Current active question: Bordered/Outlined or Highlighted? HTML shows Item 2 (Active) as White bg + Primary Border + Scale 110.
    // 2. Answered question: Green bg (HTML Item 1).
    // 3. Default: White bg + Gray border.

    Color bgColor = isDark ? cardDark : cardLight;
    Color borderColor = isDark ? Colors.grey[700]! : Colors.grey[300]!;
    Color textColor = isDark ? Colors.grey[400]! : Colors.grey[500]!;
    double scale = 1.0;
    BoxShadow? shadow;

    if (isActive) {
        bgColor = isDark ? cardDark : cardLight;
        borderColor = primaryColor;
        textColor = primaryColor;
        scale = 1.1;
        shadow = BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 8, spreadRadius: 1);
    } else if (isAnswered) {
        bgColor = successColor;
        borderColor = successColor;
        textColor = Colors.white;
    }

    return GestureDetector(
      onTap: exists ? () => _jumpToQuestion(index) : null,
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: isActive ? 2 : 1),
            boxShadow: shadow != null ? [shadow] : [],
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
      ),
    );
  }

  Widget _buildOptionItem(int index, String text, bool isDark) {
    final bool isSelected = _selectedAnswers[_currentIndex] == index;
    final String letter = String.fromCharCode(65 + index);
    
    // Theme Colors
    final Color selectedBg = secondaryColor; 
    final Color selectedBorder = secondaryColor;
    
    final Color defaultBg = isDark ? const Color(0xFF3F3F46) : const Color(0xFFF3F4F6);
    final Color hoverBg = isDark ? const Color(0xFF52525B) : const Color(0xFFE5E7EB); // Simulating hover with just a darker shade if needed, layout uses flat default.

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => _selectOption(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? selectedBg : defaultBg,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isSelected ? [
              BoxShadow(
                color: secondaryColor.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              )
            ] : [],
          ),
          child: Row(
            children: [
              // Circle Letter
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white.withOpacity(0.2) : (isDark ? Colors.grey[600] : Colors.white),
                  shape: BoxShape.circle,
                  border: isSelected ? null : Border.all(color: Colors.transparent), // Flat in HTML for unselected
                ),
                alignment: Alignment.center,
                child: Text(
                  letter,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : (isDark ? Colors.grey[300] : Colors.grey[500]),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Option Text
              Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    color: isSelected ? Colors.white : (isDark ? Colors.grey[200] : const Color(0xFF374151)),
                  ),
                ),
              ),
              // Optional Checkmark for selected
              if (isSelected)
                const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
