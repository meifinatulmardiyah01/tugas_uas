import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String title;
  final String initialThumbnailUrl;

  const VideoPlayerScreen({
    super.key,
    this.title = 'Video - User Interface Design For Beginner',
    this.initialThumbnailUrl = 'https://lh3.googleusercontent.com/aida-public/AB6AXuBiSgcbt3RIPabYJrnEtvNVgeBj6hCfLNYjzWFS7GNCiBRVJ88WY3qC51_rT6taP25jKarNYO6teWxUuMZ-1MFmheqv4968aNS1ileINkrj4Na8TUD82ll9P5scfhLz0eCGGP_OMbyYtPrCap6p3qluVfISigdIN0m8BfFl_NWc9W4sdm6b63ZCPxhRScXOySI1WTh8f3wee3jjxv08CjvaKufqjBQJr0QhGEJdyB2XFfVIPE-kjR_ZCYTH9S9Qbv1zTECeuNWvwHvJ',
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  // Theme Colors (Purple & Pink as requested)
  final Color primaryColor = const Color(0xFF8B5CF6); // Violet
  final Color secondaryColor = const Color(0xFFEC4899); // Pink
  
  // State
  late String _currentTitle;
  late String _currentThumbnail;
  bool _isPlaying = false;
  
  // Playlist Data
  final List<Map<String, String>> _playlist = [
    {
      'title': 'Interaction Design',
      'thumbnail': 'https://lh3.googleusercontent.com/aida-public/AB6AXuD8Jvmnc6N3rNu7er0d7qTPny5K6QnXjfsUPi6msok7VkMLRQxuAAdKEqIB-MZmM_dD7nAC6l--f8qsjSczbkSOrdpyvHMxZZDndcF8gjADnjlFpY_0nBIItYtCQVE98_-szZk_4908mqteXQ2i0VS1hC49QhFoCUMZCJ4Ecb5mWKmGdRt0yWKFzopnl6BVkMo0botD2EVIw42N1Xf6Rw9G944wY_7Itw1n5CwICd7YvzDXsd1acJnVBJ-wzYQTk2kb6CrMpi9_10sX',
      'tag': ''
    },
    {
      'title': 'Pengantar Desain Antarmuka Pengguna',
      'thumbnail': 'https://lh3.googleusercontent.com/aida-public/AB6AXuA7g8ftPleK0Tli2rcbsmiaA9CmPyL2TogtFJcB8ESDJtaTObfaBg-tL49gFcxr2U_cwMyqf5wTi2YOz3spK7TzhjNNyz8o0cYB__r4-dxEtDwYIT2WBS_NkkUvstvPLH5yVfs-T8JGIMTZ9KOux9PQ2O5S0tHsU4jamTyw3UKCfze1nrPDzquOVD4bcbdt1swCCDE70dWGQoqWup22Sj31k3un46KhoBUmK2rfVK7a0RQ3RdPO8i7X6JIeyKAOrAEgsHluIyl9t2n_',
      'tag': 'LIVE'
    },
    {
      'title': '4 Teori Dasar Desain Antarmuka Pengguna',
      'thumbnail': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBGVAZrRaEKkvsC2GYExdBSDJtaTObfaBg-tL49gFcxr2U_cwMyqf5wTi2YOz3spK7TzhjNNyz8o0cYB__r4-dxEtDwYIT2WBS_NkkUvstvPLH5yVfs-T8JGIMTZ9KOux9PQ2O5S0tHsU4jamTyw3UKCfze1nrPDzquOVD4bcbdt1swCCDE70dWGQoqWup22Sj31k3un46KhoBUmK2rfVK7a0RQ3RdPO8i7X6JIeyKAOrAEgsHluIyl9t2n_',
      'tag': ''
    },
    {
      'title': 'Tutorial Dasar Figma - UI/UX Design Software',
      'thumbnail': 'https://lh3.googleusercontent.com/aida-public/AB6AXuC4DKT54Sw1KPehTGKtvrtfkOuZc1BBIHo5Cwooky0vhLvZbQQfvRfk0qhB5Dn1ERlkkCO7W3xnXRGAZIQV64egJe1ptlvxhSeozAxYtEgmt2P1FUqHGwWY9oYTxRFjbGoP2BBNWiFzhCrSZeFZKTaPN3OqnA1CN2U_cNRsD9nJtEOnDzSxZB9sprMKKg4BDBSNugFcfH9cTgL9RJm-szB3X1gMFVAvxsAceWXjj3CezA9FcVufCWmwuyqju1NajirlUmD_ldEmbw7R',
      'tag': ''
    },
  ];

  @override
  void initState() {
    super.initState();
    _currentTitle = widget.title;
    _currentThumbnail = widget.initialThumbnailUrl;
  }

  void _playVideo() {
    setState(() {
      _isPlaying = true;
    });
  }

  void _switchVideo(String title, String thumbnail) {
    setState(() {
      _currentTitle = title;
      _currentThumbnail = thumbnail;
      _isPlaying = false; // Reset to stopped when switching
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF111827) : Colors.white,
      appBar: AppBar(
        title: Text(
          _currentTitle,
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: secondaryColor, // Fuchsia/Pink as requested
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Column(
        children: [
          // Video Player Area
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.black,
              child: _isPlaying ? _buildPlayingState() : _buildStoppedState(),
            ),
          ),

          // "Video Lain Nya" Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            color: isDark ? const Color(0xFF1F2937) : Colors.white, // Surface color
            child: Text(
              'Video Lain Nya',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF111827),
              ),
            ),
          ),

          // Playlist
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 24),
              itemCount: _playlist.length,
              itemBuilder: (context, index) {
                final video = _playlist[index];
                return _buildVideoItem(
                  video['title']!, 
                  video['thumbnail']!, 
                  video['tag']!, 
                  isDark
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoppedState() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          _currentThumbnail,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[900]),
        ),
        // Dark Overlay
        Container(color: Colors.black.withOpacity(0.4)),
        
        // Center Text
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
              backdropFilter: null, // No blur for performance
            ),
            child: Text(
              'UI\nDESIGN',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 4,
                height: 1.1,
              ),
            ),
          ),
        ),

        // Play Button Overlay
        Center(
          child: IconButton(
            iconSize: 64,
            icon: const Icon(Icons.play_circle_filled, color: Colors.white),
            onPressed: _playVideo,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            style: IconButton.styleFrom(
              shadowColor: Colors.black54,
              elevation: 8,
            ),
          ),
        ),

        // Bottom Progress Bar (Fake)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 4,
            width: double.infinity,
            color: Colors.grey[600],
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.3,
              child: Container(color: secondaryColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayingState() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Simulated Video Content
        Center(
          child: Text(
            'Playing: $_currentTitle',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        const Center(
          child: SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
        
        // Controls Overlay
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {},
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black87],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _isPlaying = false),
                    child: const Icon(Icons.pause, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  const Text('00:05 / 15:00', style: TextStyle(color: Colors.white, fontSize: 12)),
                  const Expanded(
                    child: Slider(
                      value: 0.1,
                      onChanged: null,
                      activeColor: Colors.pink,
                      inactiveColor: Colors.grey,
                    ),
                  ),
                  const Icon(Icons.fullscreen, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVideoItem(String title, String thumbnail, String tag, bool isDark) {
    bool isActive = title == _currentTitle;
    
    return GestureDetector(
      onTap: () => _switchVideo(title, thumbnail),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isActive 
              ? (isDark ? primaryColor.withOpacity(0.1) : secondaryColor.withOpacity(0.05))
              : (isDark ? const Color(0xFF111827) : Colors.white),
          border: Border(
            left: BorderSide(
              color: isActive ? secondaryColor : Colors.transparent,
              width: 4,
            ),
          ),
        ),
        child: Row(
          children: [
            // Thumbnail
            SizedBox(
              width: 128,
              height: 72,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey),
                    ),
                  ),
                  if (tag.isNotEmpty)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  if (!isActive)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.play_arrow, color: Colors.white, size: 24),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Title
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                  color: isActive
                      ? (isDark ? Colors.white : secondaryColor)
                      : (isDark ? Colors.grey[200] : const Color(0xFF1F2937)),
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
