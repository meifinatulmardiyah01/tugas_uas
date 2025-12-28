import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConceptDetailScreen extends StatefulWidget {
  const ConceptDetailScreen({super.key});

  @override
  State<ConceptDetailScreen> createState() => _ConceptDetailScreenState();
}

class _ConceptDetailScreenState extends State<ConceptDetailScreen> {
  int _activeTab = 0; // 0 = Lampiran Materi, 1 = Tugas dan Kuis
  final Color primaryColor = const Color(0xFF10B981); // green
  final Color secondaryColor = const Color(0xFF6366F1); // indigo

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF111827) : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: isDark ? Colors.white : Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Konsep UI Design', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : Colors.black87,
        actions: [
          // optional actions can be added here
        ],
      ),
      body: Column(
        children: [
          // Header description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Konsep User Interface Design',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Pelajari dasar‑dasar UI/UX, prinsip interaction, dan contoh materi.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Tab bar
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[100]!)),
            ),
            child: Row(
              children: [
                _buildTabItem('Lampiran Materi', 0, isDark),
                _buildTabItem('Tugas dan Kuis', 1, isDark),
              ],
            ),
          ),
          // Tab content
          Expanded(
            child: _activeTab == 0 ? _buildMaterialList(isDark) : _buildAssignmentPlaceholder(isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, int index, bool isDark) {
    bool isActive = _activeTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: isActive ? primaryColor : Colors.transparent, width: 2)),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  color: isActive ? (isDark ? Colors.white : Colors.black) : Colors.grey[400],
                ),
              ),
              if (isActive)
                Positioned(
                  bottom: -12,
                  child: Container(
                    width: 80,
                    height: 4,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.5),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
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
      padding: const EdgeInsets.all(24),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Membuka ${item['title']}...')),
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF27272A) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[100]!),
                boxShadow: isDark ? [] : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
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
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  Icon(
                    item['completed'] ? Icons.check_circle : Icons.settings_rounded,
                    color: item['completed'] ? Colors.green : Colors.grey[300],
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

  Widget _buildAssignmentPlaceholder(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_rounded, size: 64, color: Colors.grey.withOpacity(0.2)),
          const SizedBox(height: 16),
          Text('Tidak ada tugas/kuis khusus', style: GoogleFonts.inter(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }
}
