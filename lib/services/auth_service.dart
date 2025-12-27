class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Profile data
  String _currentUsername = '';
  String _firstName = 'Meifinatul';
  String _lastName = 'Mardiyah';
  String _email = 'meifinatulm@365.telkomuniversity.ac.id';
  String _country = 'Indonesia';
  String _description = 'Student at Telkom University';
  String _prodi = 'Teknik Informatika';
  String _fakultas = 'Teknik';
  String _avatarUrl = 'https://i.pinimg.com/736x/21/df/f5/21dff5738865d481b4904033327d7f95.jpg'; 

  final List<Map<String, dynamic>> _courses = [
    {
      'title': 'Bahasa Inggris: Business and Scientific',
      'code': 'D4SM-41-GAB1 [ARS]',
      'date': 'Monday, 8 February 2021',
      'icon': 'language',
      'color': 0xFFEDE9FE, 
      'iconColor': 0xFF8B5CF6,
      'instructor': 'Drs. Ahmad Fuadi, M.Pd.',
      'description': 'Mata kuliah ini membekali mahasiswa dengan kemampuan berkomunikasi dalam konteks bisnis dan penulisan ilmiah.',
      'progress': 0.75,
      'modules': [
        {'title': 'Introduction to Business English', 'type': 'video', 'duration': '15:00', 'completed': true},
        {'title': 'Scientific Writing Basics', 'type': 'pdf', 'duration': '2.5 MB', 'completed': true},
        {'title': 'Business Correspondence', 'type': 'video', 'duration': '12:45', 'completed': true},
        {
          'title': 'Scientific Vocabulary Quiz', 
          'type': 'quiz', 
          'duration': '5 Qs', 
          'completed': false,
          'questions': [
            {
              'text': 'What is the correct term for a detailed study of a subject?',
              'options': ['Research', 'Casual reading', 'Opinion', 'Guesswork'],
              'correctAnswer': 0,
            },
            {
              'text': 'In business letters, what does "CC" stand for?',
              'options': ['Carbon Copy', 'Cancel Connection', 'Company Code', 'Chief Commander'],
              'correctAnswer': 0,
            },
            {
              'text': 'Which word indicates a formal proposal?',
              'options': ['Chat', 'Vibe', 'Proposal', 'Meme'],
              'correctAnswer': 2,
            },
            {
              'text': 'What is a "Summary"?',
              'options': ['Short version of a text', 'Full original text', 'The title only', 'List of names'],
              'correctAnswer': 0,
            },
            {
              'text': 'Effective communication in business avoids:',
              'options': ['Clarity', 'Ambiguity', 'Politeness', 'Structure'],
              'correctAnswer': 1,
            },
          ],
        },
      ],
    },
    {
      'title': 'Desain Antarmuka & Pengalaman Pengguna',
      'code': 'D4SM-42-03 [ADY]',
      'date': 'Monday, 8 February 2021',
      'icon': 'design_services',
      'color': 0xFFFCE7F3,
      'iconColor': 0xFFEC4899,
      'instructor': 'Aditya Pratama, M.Ds.',
      'description': 'Fokus pada prinsip desain UI/UX, user research, dan prototyping untuk aplikasi multimedia.',
      'progress': 0.45,
      'modules': [
        {'title': 'Prinsip Dasar UI Design', 'type': 'video', 'duration': '20:30', 'completed': true},
        {'title': 'User Centered Design', 'type': 'pdf', 'duration': '1.8 MB', 'completed': true},
        {'title': 'Prototyping with Figma', 'type': 'video', 'duration': '18:15', 'completed': false},
        {
          'title': 'UTS: Design Portfolio', 
          'type': 'quiz', 
          'duration': 'Basic Qs', 
          'completed': false,
          'questions': [
            {
              'text': 'What does UI stand for?',
              'options': ['User Interest', 'User Interface', 'Unity Interaction', 'Unique Identity'],
              'correctAnswer': 1,
            },
            {
              'text': 'Which color is often used for a "Primary Button"?',
              'options': ['Light Gray', 'Vibrant Color (Blue/Fuchsia)', 'White', 'Dashed Border'],
              'correctAnswer': 1,
            },
          ],
        },
      ],
    },
    {
      'title': 'Kewarganegaraan',
      'code': 'D4SM-41-GAB1 [BBO], JUMAT 2',
      'date': 'Monday, 8 February 2021',
      'icon': 'public',
      'color': 0xFFF3E8FF,
      'iconColor': 0xFFA855F7,
      'instructor': 'Dr. Bambang Setiawan, M.Hum.',
      'description': 'Membangun karakter warga negara yang cerdas, bertanggung jawab, dan berbudi pekerti luhur.',
      'progress': 0.90,
      'modules': [
        {'title': 'Identitas Nasional', 'type': 'video', 'duration': '10:00', 'completed': true},
        {'title': 'Hak dan Kewajiban Warga Negara', 'type': 'video', 'duration': '14:20', 'completed': true},
        {'title': 'Wawasan Nusantara', 'type': 'pdf', 'duration': '3.2 MB', 'completed': true},
        {
          'title': 'Quiz Wawasan Kebangsaan', 
          'type': 'quiz', 
          'duration': '3 Qs', 
          'completed': true,
          'questions': [
            {
              'text': 'Apa lambang negara Indonesia?',
              'options': ['Garuda Pancasila', 'Beringin', 'Harimau', 'Elang'],
              'correctAnswer': 0,
            },
            {
              'text': 'Bhinneka Tunggal Ika artinya?',
              'options': ['Satu nusa satu bangsa', 'Berbeda-beda tetapi tetap satu', 'Persatuan Indonesia', 'Keadilan sosial'],
              'correctAnswer': 1,
            },
            {
              'text': 'UUD 1945 disahkan pada tanggal?',
              'options': ['17 Agustus 1945', '18 Agustus 1945', '1 Juni 1945', '20 Mei 1945'],
              'correctAnswer': 1,
            }
          ],
        },
      ],
    },
    {
      'title': 'Olah Raga',
      'code': 'D3TT-44-02 [EYR]',
      'date': 'Monday, 8 February 2021',
      'icon': 'sports_soccer',
      'color': 0xFFDBEAFE,
      'iconColor': 0xFF3B82F6,
      'instructor': 'Eko Yulianto, S.Or.',
      'description': 'Meningkatkan kebugaran jasmani dan pemahaman tentang berbagai cabang olahraga.',
      'progress': 0.60,
      'modules': [
        {'title': 'Kebugaran Jasmani', 'type': 'video', 'duration': '08:45', 'completed': true},
        {'title': 'Teknik Dasar Sepak Bola', 'type': 'video', 'duration': '15:30', 'completed': true},
        {'title': 'Nutrisi Olahraga', 'type': 'pdf', 'duration': '1.2 MB', 'completed': false},
      ],
    },
    {
      'title': 'Pemrograman Multimedia Interaktif',
      'code': 'D4SM-43-04 [TPR]',
      'date': 'Monday, 8 February 2021',
      'icon': 'code',
      'color': 0xFFE0E7FF,
      'iconColor': 0xFF6366F1,
      'instructor': 'Taufik Rahman, M.T.',
      'description': 'Pemrograman aplikasi interaktif menggunakan tool multimedia modern.',
      'progress': 0.30,
      'modules': [
        {'title': 'Intro to Logic Programming', 'type': 'video', 'duration': '25:00', 'completed': true},
        {'title': 'Animation with Scripting', 'type': 'video', 'duration': '30:00', 'completed': false},
        {'title': 'Interactive Controls', 'type': 'pdf', 'duration': '4.5 MB', 'completed': false},
      ],
    },
    {
      'title': 'Pemrograman Perangkat Bergerak Multimedia',
      'code': 'D4SM-41-GAB1 [APJ]',
      'date': 'Monday, 8 February 2021',
      'icon': 'smartphone',
      'color': 0xFFFFE4E6,
      'iconColor': 0xFFF43F5E,
      'instructor': 'Arip Junaidi, M.Kom.',
      'description': 'Pengembangan aplikasi mobile berbasis multimedia untuk platform Android dan iOS.',
      'progress': 0.50,
      'modules': [
        {'title': 'Mobile Design Patterns', 'type': 'video', 'duration': '18:00', 'completed': true},
        {'title': 'Flutter Fundamentals', 'type': 'video', 'duration': '22:45', 'completed': true},
        {'title': 'Multimedia Integration', 'type': 'pdf', 'duration': '2.1 MB', 'completed': false},
      ],
    },
    {
      'title': 'Sistem Operasi',
      'code': 'D4SM-44-02 [DDS]',
      'date': 'Monday, 8 February 2021',
      'icon': 'settings_system_daydream',
      'color': 0xFFCCFBF1,
      'iconColor': 0xFF14B8A6,
      'instructor': 'Dedi Dwi Syahputra, M.T.',
      'description': 'Mempelajari konsep dasar sistem operasi, manajemen memori, dan file system.',
      'progress': 0.20,
      'modules': [
        {'title': 'Konsep Dasar OS', 'type': 'video', 'duration': '12:00', 'completed': true},
        {'title': 'Process Management', 'type': 'video', 'duration': '18:30', 'completed': false},
        {'title': 'Memory Management', 'type': 'pdf', 'duration': '2.8 MB', 'completed': false},
      ],
    },
  ];

  String get currentUsername => _currentUsername;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get fullName => '$_firstName $_lastName';
  String get email => _email;
  String get country => _country;
  String get description => _description;
  String get prodi => _prodi;
  String get fakultas => _fakultas;
  String get avatarUrl => _avatarUrl;
  List<Map<String, dynamic>> get courses => _courses;

  bool validate(String username, String password) {
    if (username.endsWith('.ac.id') && password.isNotEmpty) {
      _currentUsername = username;
      _email = username; // Sync email with username
      return true;
    }
    return false;
  }

  void updateProfile({
    String? firstName, 
    String? lastName, 
    String? email,
    String? country,
    String? description,
    String? prodi, 
    String? fakultas, 
    String? avatarUrl
  }) {
    if (firstName != null) _firstName = firstName;
    if (lastName != null) _lastName = lastName;
    if (email != null) _email = email;
    if (country != null) _country = country;
    if (description != null) _description = description;
    if (prodi != null) _prodi = prodi;
    if (fakultas != null) _fakultas = fakultas;
    if (avatarUrl != null) _avatarUrl = avatarUrl;
  }

  void updateCredentials(String newUsername) {
    _currentUsername = newUsername;
  }
}
