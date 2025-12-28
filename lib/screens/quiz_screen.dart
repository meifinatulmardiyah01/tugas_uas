import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_saya/screens/quiz_review_screen.dart';

class QuizScreen extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> questions;

  const QuizScreen({super.key, required this.title, required this.questions});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Theme Colors
  // User requested Purple/Pink combo generally, but HTML specific elements (Grid Answered) are Green.
  final Color primaryColor = const Color(0xFF8B5CF6); // Purple 500 (Header)
  final Color secondaryColor = const Color(0xFFDB2777); // Pink 600 (Primary Action/Selection)
  final Color successColor = const Color(0xFF4ADE80); // Bright Green (Answered / Finish)
  final Color backgroundLight = const Color(0xFFF9FAFB);
  final Color backgroundDark = const Color(0xFF18181B);
  final Color cardLight = Colors.white;
  final Color cardDark = const Color(0xFF27272A);

  int _currentIndex = 0;
  final Map<int, int> _selectedAnswers = {}; 
  
  Timer? _timer;
  int _remainingSeconds = 900;

  @override
  void initState() {
    super.initState();
    _startTimer();
    
    // Simulate pre-filled answers 1-14 as per HTML design visualization "1-14 Green"
    // In a real app we start empty.
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_remainingSeconds > 0) {
            _remainingSeconds--;
          } else {
            _timer?.cancel();
            _finishQuiz();
          }
        });
      }
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
      setState(() {
        _currentIndex = index;
      });
  }

  void _finishQuiz() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizReviewScreen(
            questions: widget.questions,
            userAnswers: _selectedAnswers,
        ),
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
          // Header
          Container(
            padding: const EdgeInsets.only(top: 50, bottom: 25, left: 24, right: 24),
            decoration: BoxDecoration(
              color: primaryColor, // Purple Header as req
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Column(
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
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.timer_outlined, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          _formatTime(_remainingSeconds),
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
              children: [
                // Grid
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    widget.questions.length > 15 ? widget.questions.length : 15,
                    (index) => _buildGridItem(index, isDark),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Question Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'Soal Nomor ${_currentIndex + 1}',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.grey[900],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '/ ${widget.questions.length}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.grey[400] : Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                Text(
                  currentQuestion['text'],
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.grey[200] : const Color(0xFF374151),
                  ),
                ),
                
                const SizedBox(height: 24),
                
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
              border: Border(top: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[100]!)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _currentIndex > 0 ? _prevQuestion : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? Colors.grey[800] : const Color(0xFFF3F4F6),
                      foregroundColor: isDark ? Colors.grey[300] : const Color(0xFF4B5563),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      'Soal Sebelumnya',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (_currentIndex == widget.questions.length - 1) 
                          ? successColor // Green for finish (as per HTML logic)
                          : secondaryColor, // Pink for Next
                      foregroundColor: (_currentIndex == widget.questions.length - 1)
                          ? Colors.black // Dark text on Green
                          : Colors.white,
                      elevation: 4,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      _currentIndex == widget.questions.length - 1 ? 'Selesai' : 'Soal Selanjutnya',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
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
    bool isActive = index == _currentIndex;
    bool isAnswered = index < widget.questions.length && _selectedAnswers.containsKey(index);
    bool exists = index < widget.questions.length;
    
    Color bgColor = isDark ? cardDark : cardLight;
    Color textColor = isDark ? Colors.grey[400]! : Colors.grey[500]!;
    
    if (isAnswered) {
        bgColor = successColor; // Green
        textColor = Colors.black; // Dark text on green
    } else if (isActive) {
        // Active ring
    }

    return GestureDetector(
      onTap: exists ? () => _jumpToQuestion(index) : null,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border: isActive 
              ? Border.all(color: successColor, width: 2) // Active gets Green ring
              : (!isAnswered ? Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[300]!) : null),
           boxShadow: isAnswered ? [
             BoxShadow(color: successColor.withOpacity(0.4), blurRadius: 4, offset: const Offset(0, 2))
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

  Widget _buildOptionItem(int index, String text, bool isDark) {
    bool isSelected = _selectedAnswers[_currentIndex] == index;
    String letter = String.fromCharCode(65 + index);

    // Selected style: Pink Background (User Theme)
    // HTML used Pink/Red for selected ("primary"), so we use secondaryColor (Pink 600)
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => _selectOption(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? secondaryColor : (isDark ? const Color(0xFF3F3F46) : const Color(0xFFF3F4F6)),
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected ? [
              BoxShadow(
                color: secondaryColor.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ] : [],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                child: Text(
                  '$letter.',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : (isDark ? Colors.grey[400] : Colors.grey[900]),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : (isDark ? Colors.grey[200] : const Color(0xFF374151)),
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
