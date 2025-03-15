import 'dart:convert';
import 'package:flutter/services.dart';

class MockApiService {
  // Fetch user data from local JSON file
  Future<Map<String, dynamic>> fetchUserData() async {
    final response = await rootBundle.loadString('assets/sample_data.json');
    final data = json.decode(response);
    return data;
  }

  // Simulate payment processing
  Future<Map<String, dynamic>> simulatePayment({
    required String receiver,
    required double amount,
  }) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    if (amount > 0) {
      return {
        'status': 'success',
        'message': 'Payment of ₹$amount to $receiver was successful'
      };
    } else {
      return {'status': 'failed', 'message': 'Invalid payment amount'};
    }
  }
}
