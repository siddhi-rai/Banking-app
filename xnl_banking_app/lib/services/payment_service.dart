class PaymentService {
  Future<Map<String, dynamic>> processPayment({
    required String receiver, // ✅ Ensure correct parameter names
    required double amount, // ✅ Ensure correct parameter names
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Simulate a success rate of 80%
      bool isSuccess = DateTime.now().millisecondsSinceEpoch % 5 != 0;

      if (isSuccess) {
        return {'status': 'success', 'receiver': receiver, 'amount': amount};
      } else {
        throw Exception('Payment failed due to network issue.');
      }
    } catch (e) {
      return {'status': 'failed', 'error': e.toString()};
    }
  }
}
