import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_saya/screens/file_upload_screen.dart'; // Import FileUploadScreen

class AssignmentDetailScreen extends StatelessWidget {
  const AssignmentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xFFBE185D); // Pink 700
    final primaryLight = const Color(0xFFF472B6); // Pink 400

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF111827) : const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: Text(
          'Tugas 01 - UID Android Mobile Game',
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Instructions Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1F2937) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInstructionItem('1.', 'Buatlah desain tampilan (antarmuka) pada aplikasi mobile game FPS (First Person Shooter) yang akan menjadi tugas pada mata kuliah Pemrograman Aplikasi Permainan.', isDark),
                  _buildInstructionItem('2.', 'Desain yang dibuat harus melingkupi seluruh tampilan pada aplikasi/game, dari pertama kali aplikasi dibuka sampai ditutup kembali, serta desain untuk tampilan-tampilan fungsi yang mendukung permainan seperti pop-up, alert, chat, dan lain-lain.', isDark),
                  _buildInstructionItem('3.', 'Desain bisa dibuat menggunakan aplikasi khusus desain atau secara manual dengan tetap menjunjung kerapihan dan kejelasan setiap elemen dalam desain.', isDark),
                  _buildInstructionItem('4.', 'Berikan identitas aplikasi game yang dibuat, seperti Nama Game, Genre, dan Platform. Serta berikan penjelasan pada setiap elemen pada desain, seperti gambar, teks, tombol, icon, dan lain-lain.', isDark),
                  _buildInstructionItem('5.', 'File dikumpulkan dalam format .PDF dengan size maksimal 5MB.', isDark),
                  _buildInstructionItem('6.', 'Tugas dikumpulkan paling lambat hari Jum\'at, 26 Februari 2021 jam 23:59 WIB (akan tertutup otomatis) dan akan dipresentasikan pada pertemuan selanjutnya via Zoom Meeting.', isDark),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Status Table Section
            Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1F2937) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                     color: primaryLight,
                     child: Text(
                       'STATUS TUGAS',
                       style: GoogleFonts.inter(
                         color: Colors.white,
                         fontSize: 14,
                         fontWeight: FontWeight.bold,
                         letterSpacing: 1,
                       ),
                     ),
                   ),
                   _buildStatusRow('Status', 'Sudah Mengirim untuk di nilai', isDark, isEven: true),
                   _buildStatusRow('Status Nilai', 'Belum Dinilai', isDark, isEven: false),
                   _buildStatusRow('Batas tanggal', 'Jumat, 26 Februari 2021, 23:59 WIB', isDark, isEven: true),
                   _buildStatusRow('Sisa Waktu', 'Tugas sudah di kirim 4 Hari 6 Jam Sebelum nya', isDark, isEven: false),
                   _buildFileRow('File Tugas', 'Meifinatul_Mardiyah_770817014.pdf', isDark, isEven: true, context: context),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => const FileUploadScreen()),
                   );
                },
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Tambahkan Tugas'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
                  foregroundColor: isDark ? Colors.white : const Color(0xFF1F2937),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  textStyle: GoogleFonts.inter(fontWeight: FontWeight.bold),
                  elevation: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionItem(String number, String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 14,
                height: 1.5,
                color: isDark ? Colors.grey[300] : const Color(0xFF4B5563),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String value, bool isDark, {required bool isEven}) {
    final backgroundColor = isEven 
        ? (isDark ? const Color(0xFF1F2937) : const Color(0xFFF9FAFB)) // Darker alternate
        : (isDark ? const Color(0xFF111827) : Colors.white);

    return Container(
      color: backgroundColor,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB))),
                ),
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey[300] : const Color(0xFF374151),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: isDark ? Colors.white : const Color(0xFF111827),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileRow(String label, String fileName, bool isDark, {required bool isEven, required BuildContext context}) {
    final backgroundColor = isEven 
        ? (isDark ? const Color(0xFF1F2937) : const Color(0xFFF9FAFB)) 
        : (isDark ? const Color(0xFF111827) : Colors.white);

    return Container(
      color: backgroundColor,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB))),
                ),
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey[300] : const Color(0xFF374151),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.all(12),
                child: InkWell(
                  onTap: () {
                     ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text('Downloading $fileName...')),
                     );
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.description, color: Color(0xFFBE185D), size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          fileName,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color(0xFFBE185D), // Primary color for link
                            decoration: TextDecoration.underline,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
