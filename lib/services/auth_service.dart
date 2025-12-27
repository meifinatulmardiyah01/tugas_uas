class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // No fixed credentials needed anymore for this logic
  String _currentUsername = ''; 

  String get currentUsername => _currentUsername;

  bool validate(String username, String password) {
    if (username.endsWith('.ac.id') && password.isNotEmpty) {
      _currentUsername = username; // Store for the session display
      return true;
    }
    return false;
  }

  void updateCredentials(String newUsername, String newPassword) {
    // This is less relevant now with flexible login, but kept for consistency
    _currentUsername = newUsername;
  }
}
