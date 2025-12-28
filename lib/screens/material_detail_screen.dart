import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialDetailScreen extends StatelessWidget {
  const MaterialDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF18181B) : const Color(0xFFFDF2F8), // Pink-50 / Zinc-900
      body: Stack(
        children: [
          // Content
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 80, left: 16, right: 16, bottom: 32),
            child: Column(
              children: [
                _buildHeroCard(isDark),
                const SizedBox(height: 24),
                _buildProfileCard(isDark),
                const SizedBox(height: 24),
                _buildDefinitionCard(isDark),
                const SizedBox(height: 24),
                _buildImportanceCard(isDark),
              ],
            ),
          ),

          // Custom App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF8B5CF6), // Purple 500
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      'Pengantar User Interface Design',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'HALAMAN',
                          style: GoogleFonts.inter(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        Text(
                          '1/26',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF27272A) : Colors.white, // Zinc-800 / White
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: isDark ? const Color(0xFF3F3F46) : const Color(0xFFFCE7F3)), // Zinc-700 / Pink-100
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBWj6xApSoI9-WD6qng99oD-sbcOfomihfZ4jcQD1XPrSP_stkZHzBup2DW6AlzowQO1IZeNUhsuCv3E1I1sCPp2Sjc6hJ1VZv4wiIvCVn_-N4qJU8w5icIWTwf8YwZruHoRMCy54UgtE6j2okvFHMGSkKACq2BdHdmhP92SBsyEuVQJeytTxbkSAgl7WH7fYvzwQ-T6e8ShlJ8DADz3nv4hz7P06RQe1WVE0tWY0P_UZTwROnzMrZH3cSDXOlBa9Xlf2iZLabKoGo4',
                height: 192,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.school, color: Color(0xFFDB2777), size: 32),
                      const SizedBox(height: 4),
                      Text(
                        'Universitas Telkom',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: isDark ? Colors.black : const Color(0xFF27272A),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 12),
                  decoration: const BoxDecoration(
                    border: Border(left: BorderSide(color: Color(0xFFDB2777), width: 4)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pengantar Desain',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Antarmuka Pengguna',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'VEI214',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFDB2777),
                      ),
                    ),
                    Text(
                      'UI / UX Design',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: const Color(0xFFDB2777).withOpacity(0.8),
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
  }

  Widget _buildProfileCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF27272A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: isDark ? const Color(0xFF3F3F46) : const Color(0xFFFCE7F3)),
      ),
      child: Column(
        children: [
          Text(
            'Perkenalan',
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: isDark ? const Color(0xFF52525B) : Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                    ),
                  ],
                  image: const DecorationImage(
                    // Female placeholder avatar
                    image: NetworkImage('https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg'), // Placeholder, better if I have a female one handy or use standard placeholder
                    // Let's use a generic graphics placeholder for safety in a real app, but here I'll use a female avatar URL
                    // image: NetworkImage('https://i.pravatar.cc/300?img=5'), // Example female
                    // Using a safe reliable one if possible, or just the one from HTML but modified?
                    // I will stick to a generic female avatar URL.
                  ),
                ),
                child: const CircleAvatar(
                   backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026024d'), // Random female avatar
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    _buildProfileItem('•', 'Meifinatul Mardiyah', ' -> ADY', isDark),
                    _buildProfileItem('•', 'E-mail:', '\nmeifinatul@telkomuniversity.ac.id', isDark, isLink: true),
                    _buildProfileItem('•', 'Bidang Keahlian:', '', isDark, listItems: ['Information System', 'Web Programming', 'Game Development']),
                    _buildProfileItem('•', 'No.HP:', ' 085727930642 ->\nSMS/Telp/Whatsapp', isDark),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(String bullet, String label, String value, bool isDark, {bool isLink = false, List<String>? listItems}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(bullet, style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: const Color(0xFFDB2777))),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(fontSize: 13, color: isDark ? Colors.grey[300] : const Color(0xFF1F2937)),
                    children: [
                      TextSpan(text: label, style: const TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(
                        text: value, 
                        style: TextStyle(
                          color: isLink ? const Color(0xFFDB2777) : (isDark ? Colors.grey[400] : Colors.grey[500]),
                          decoration: isLink ? TextDecoration.underline : null,
                        )
                      ),
                    ],
                  ),
                ),
                if (listItems != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: listItems.map((item) => Text(
                        '- $item',
                        style: GoogleFonts.inter(fontSize: 12, color: isDark ? Colors.grey[400] : const Color(0xFF4B5563), fontStyle: FontStyle.italic),
                      )).toList(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefinitionCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF27272A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? const Color(0xFF3F3F46) : const Color(0xFFFCE7F3)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Text(
            'User Interface',
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: isDark ? Colors.white : const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 24),
          _buildBulletPoint('Antarmuka/ user interface (UI) merupakan bagian dari komputer dan perangkat lunaknya yang dapat dilihat, didengar, disentuh, dan diajak bicara.', isDark),
          _buildBulletPoint('UI yang baik adalah UI yang tidak disadari, dan UI yang memungkinkan pengguna fokus pada informasi dan task.', isDark),
          _buildBulletPoint('Komponen utamanya:\n- Input\n- Output', isDark, isList: true),
        ],
      ),
    );
  }

  Widget _buildImportanceCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF27272A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? const Color(0xFF3F3F46) : const Color(0xFFFCE7F3)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Pentingnya Desain UI yang Baik',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF1F2937),
            ),
          ),
           const SizedBox(height: 24),
           _buildBulletPoint('Banyak sistem dengan fungsionalitas yang baik tapi tidak efisien karena desain UI yang buruk.', isDark),
           _buildBulletPoint('Antarmuka yang baik merupakan jendela untuk melihat kemampuan sistem.', isDark),
           _buildBulletPoint('Desain yang buruk akan membingungkan, tidak efisien, bahkan menyebabkan frustasi.', isDark),
           const SizedBox(height: 16),
           Transform.rotate(
             angle: 0.05,
             child: ClipRRect(
               borderRadius: BorderRadius.circular(8),
               child: Image.network(
                 'https://lh3.googleusercontent.com/aida-public/AB6AXuDTcd2xY2HrH6Yytsk1HJFrhcMTcKhw7mfUawWtMlESwA7l2AbT4NdjaLJyUgpcmtQtnGizy-xqd5x1FU4oDi97moo4OaYr5PhUu1875rBYmuTrWzpOtnUEXmPJixHwzm3B3SzAkBpsJwfnfHrvNpFBYE2e5oArG7rfcUubsYhzeaikCM9cqKDvlXcvvaPfb1W-2pSn8PaBJgB4AwAZYzidldmEhPNTBhOWAF6db7ifsokQY3Wh-NbHL8SIGkqf5FqVKlb9KW2u2BM_',
                 height: 120,
                 width: double.infinity,
                 fit: BoxFit.cover,
               ),
             ),
           ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text, bool isDark, {bool isList = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text('•', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFFDB2777))),
           const SizedBox(width: 12),
           Expanded(
             child: Text(
               text,
               style: GoogleFonts.inter(
                 fontSize: 13,
                 height: 1.6,
                 color: isDark ? Colors.grey[300] : const Color(0xFF374151),
                 fontStyle: isList ? FontStyle.italic : FontStyle.normal,
               ),
             ),
           ),
        ],
      ),
    );
  }
}
