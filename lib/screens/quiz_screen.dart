import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuizScreen extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> questions;

  const QuizScreen({super.key, required this.title, required this.questions});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedOption;
  bool _isAnswered = false;
  bool _showResult = false;

  void _handleOptionSelect(int index) {
    if (_isAnswered) return;
    setState(() {
      _selectedOption = index;
      _isAnswered = true;
      if (index == widget.questions[_currentIndex]['correctAnswer']) {
        _score++;
      }
    });

    // Auto-advance after delay
    Future.delayed(const Duration(seconds: 1), () {
      if (_currentIndex < widget.questions.length - 1) {
        setState(() {
          _currentIndex++;
          _selectedOption = null;
          _isAnswered = false;
        });
      } else {
        setState(() {
          _showResult = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryGradient = const LinearGradient(
      colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
    );

    if (_showResult) return _buildResultView(isDark, primaryGradient);

    final question = widget.questions[_currentIndex];
    double progress = (_currentIndex + 1) / widget.questions.length;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF111827) : const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Text(widget.title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : Colors.black87,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${_currentIndex + 1} of ${widget.questions.length}',
                      style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFFEC4899)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFEC4899)),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1F2937) : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      question['text'],
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ).animate().fadeIn().slideY(begin: 0.1, end: 0),

                  const SizedBox(height: 32),

                  ...List.generate(
                    (question['options'] as List).length,
                    (index) => _buildOptionBtn(index, question['options'][index], question['correctAnswer'], isDark),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionBtn(int index, String text, int correctIndex, bool isDark) {
    bool isSelected = _selectedOption == index;
    bool isCorrect = index == correctIndex;
    
    Color borderCol = Colors.transparent;
    Color bgCol = isDark ? const Color(0xFF1F2937) : Colors.white;
    IconData? icon;

    if (_isAnswered) {
      if (isCorrect) {
        borderCol = Colors.green;
        bgCol = Colors.green.withValues(alpha: 0.1);
        icon = Icons.check_circle_rounded;
      } else if (isSelected) {
        borderCol = Colors.red;
        bgCol = Colors.red.withValues(alpha: 0.1);
        icon = Icons.cancel_rounded;
      }
    } else if (isSelected) {
      borderCol = const Color(0xFF8B5CF6);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _handleOptionSelect(index),
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: bgCol,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderCol, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? borderCol : Colors.grey.withValues(alpha: 0.1),
                ),
                child: Center(
                  child: Text(
                    String.fromCharCode(65 + index),
                    style: GoogleFonts.poppins(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: isDark ? Colors.white : Colors.black87,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              if (icon != null) Icon(icon, color: borderCol),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.2, end: 0);
  }

  Widget _buildResultView(bool isDark, Gradient gradient) {
    double scorePct = _score / widget.questions.length;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF111827) : const Color(0xFFF9FAFB),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events_rounded, size: 120, color: Colors.amber)
                .animate(onPlay: (c) => c.repeat())
                .shimmer(duration: 2.seconds)
                .shake(hz: 4, curve: Curves.easeInOut),
            
            const SizedBox(height: 32),
            
            Text(
              'Quiz Completed!',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            
            const SizedBox(height: 12),
            
            Text(
              'You scored',
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              '$_score / ${widget.questions.length}',
              style: GoogleFonts.poppins(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFEC4899),
              ),
            ),
            
            const SizedBox(height: 40),
            
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1F2937) : Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Text(
                    scorePct >= 0.7 ? 'Kerja Bagus! 🎉' : 'Terus Belajar! 💪',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18, color: isDark ? Colors.white : Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Anda telah menyelesaikan kuis untuk materi ini.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 60),
            
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC026D3),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 8,
                  shadowColor: const Color(0xFFC026D3).withValues(alpha: 0.4),
                ),
                child: Text('Selesai', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
