import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../services/mock_api_service.dart'; // ✅ Import the mock service

final apiProvider = Provider<ApiService>((ref) {
  return ApiService(
      baseUrl: 'https://example.com/api'); // Replace with real URL
});

final mockApiServiceProvider = Provider<MockApiService>((ref) {
  return MockApiService(); // ✅ Added mock service provider
});
