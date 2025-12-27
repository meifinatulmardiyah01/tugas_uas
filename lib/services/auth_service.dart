class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // No fixed credentials needed anymore for this logic
  String _currentUsername = '';
  String _fullName = 'Meifinatul Mardiyah';
  String _prodi = 'Teknik Informatika';
  String _fakultas = 'Teknik';
  String _avatarUrl = 'https://i.pinimg.com/736x/21/df/f5/21dff5738865d481b4904033327d7f95.jpg'; // Cute anime girl placeholder

  String get currentUsername => _currentUsername;
  String get fullName => _fullName;
  String get prodi => _prodi;
  String get fakultas => _fakultas;
  String get avatarUrl => _avatarUrl;

  bool validate(String username, String password) {
    if (username.endsWith('.ac.id') && password.isNotEmpty) {
      _currentUsername = username; // Store for the session display
      return true;
    }
    return false;
  }

  void updateProfile({String? fullName, String? prodi, String? fakultas, String? avatarUrl}) {
    if (fullName != null) _fullName = fullName;
    if (prodi != null) _prodi = prodi;
    if (fakultas != null) _fakultas = fakultas;
    if (avatarUrl != null) _avatarUrl = avatarUrl;
  }

  void updateCredentials(String newUsername) {
    _currentUsername = newUsername;
  }
}
