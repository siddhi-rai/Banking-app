import 'package:flutter/material.dart';
import '../providers/auth_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(emailProvider);
    final password = ref.watch(passwordProvider);
    final isAuthenticated = ref.watch(authProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            const Icon(Icons.account_balance, size: 60, color: Colors.blue),

            const SizedBox(height: 20),

            // Email Input
            TextField(
              onChanged: (value) =>
                  ref.read(emailProvider.notifier).state = value,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Password Input
            TextField(
              onChanged: (value) =>
                  ref.read(passwordProvider.notifier).state = value,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Login Button
            ElevatedButton(
              onPressed: () {
                ref.read(authProvider.notifier).login(email, password);
                if (isAuthenticated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login Successful')),
                  );
                  // Navigate to Dashboard
                  Navigator.pushReplacementNamed(context, '/dashboard');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid Credentials')),
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
