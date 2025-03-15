import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/mock_api_service.dart';
import '../providers/api_provider.dart';

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier(this._mockApiService) : super(false);

  final MockApiService _mockApiService;

  Future<void> login(String username, String password) async {
    try {
      final data =
          await _mockApiService.fetchUserData(); // ✅ Fetch from mock data
      print('Fetched data: $data'); // ✅ Debugging statement
      if (data['username'] == username && data['password'] == password) {
        state = true; // ✅ Successful login
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e) {
      print('Login failed: $e');
      throw Exception('Failed to login: $e');
    }
  }

  void logout() {
    state = false;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier(ref.read(mockApiServiceProvider));
});
