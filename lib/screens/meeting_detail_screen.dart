import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeetingDetailScreen extends StatefulWidget {
  final Map<String, dynamic> meeting;

  const MeetingDetailScreen({super.key, required this.meeting});

  @override
  State<MeetingDetailScreen> createState() => _MeetingDetailScreenState();
}

class _MeetingDetailScreenState extends State<MeetingDetailScreen> {
  int _activeTab = 0; // 0 for Lampiran Materi, 1 for Tugas Dan Kuis

  final Color primaryColor = const Color(0xFFD946EF);
  final Color secondaryColor = const Color(0xFFA855F7);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF18181B) : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: isDark ? Colors.white : Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Title Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              widget.meeting['title'],
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),

          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deskripsi',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Antarmuka yang dibangun harus memperhatikan prinsip-prinsip desain yang ada. Hal ini diharapkan agar antarmuka yang dibangun bukan hanya menarik secara visual tetapi dengan memperhatikan kaidah-kaidah prinsip desain diharapkan akan mendukung pengguna dalam menggunakan produk secara baik.',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Custom Tab Bar
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[100]!),
              ),
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
            child: _activeTab == 0 ? _buildMaterialList(isDark) : _buildAssignmentList(isDark),
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
            border: Border(
              bottom: BorderSide(
                color: isActive ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
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
                          color: primaryColor.withValues(alpha: 0.5),
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
    final materials = [
      {'title': 'Zoom Meeting Synchronous', 'icon': Icons.link, 'status': 'completed'},
      {'title': 'Pengantar User Interface Design', 'icon': Icons.description_outlined, 'status': 'pending'},
      {'title': 'Empat Teori Dasar Antarmuka Pengguna', 'icon': Icons.description_outlined, 'status': 'pending'},
      {'title': 'Empat Teori Dasar Antarmuka Pengguna', 'icon': Icons.description_outlined, 'status': 'completed'},
      {'title': 'User Interface Design for Beginner', 'icon': Icons.menu_book, 'status': 'completed'},
      {'title': '20 Prinsip Desain', 'icon': Icons.link, 'status': 'completed'},
      {'title': 'Best Practice UI Design', 'icon': Icons.link, 'status': 'completed'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: materials.length,
      itemBuilder: (context, index) {
        final item = materials[index];
        bool isCompleted = item['status'] == 'completed';

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
                    color: Colors.black.withValues(alpha: 0.05),
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
                      color: primaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item['icon'] as IconData, color: primaryColor, size: 20),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      item['title'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  Icon(
                    isCompleted ? Icons.check_circle : Icons.settings_rounded,
                    color: isCompleted ? Colors.green : Colors.grey[300],
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

  Widget _buildAssignmentList(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_rounded, size: 64, color: Colors.grey.withValues(alpha: 0.2)),
          const SizedBox(height: 16),
          Text(
            'Tidak ada tugas/kuis khusus',
            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
