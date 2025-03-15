import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/api_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  Map<String, dynamic>? _mockData;
  String? _error;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSampleData();
  }

  Future<void> _loadSampleData() async {
    setState(() => _isLoading = true);
    try {
      final data = await ref.read(mockApiServiceProvider).fetchUserData();
      setState(() {
        _mockData = data;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = 'Error loading data: $e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: isAuthenticated
          ? _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
                  ? Center(child: Text(_error!))
                  : _mockData != null
                      ? _buildDashboardContent(_mockData!)
                      : const Center(child: Text('No data available'))
          : const Center(child: Text('Please log in to access the dashboard')),
    );
  }

  Widget _buildDashboardContent(Map<String, dynamic> data) {
    final balance = data['balance'];
    final transactions = data['transactions'] as List<dynamic>;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome Back!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Account Balance'),
              subtitle: Text('₹$balance'),
            ),
          ),
          const SizedBox(height: 20),
          _buildPaymentButton(),
          const SizedBox(height: 20),
          const Text(
            'Recent Transactions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: transactions.isNotEmpty
                ? ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: const Icon(Icons.payment),
                          title: Text('Transaction #${index + 1}'),
                          subtitle: Text(
                              '₹${transaction['amount']} - ${transaction['status']}'),
                          trailing: transaction['status'] == 'Successful'
                              ? const Icon(Icons.check_circle,
                                  color: Colors.green)
                              : const Icon(Icons.error, color: Colors.red),
                        ),
                      );
                    },
                  )
                : const Center(child: Text('No transactions found')),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentButton() {
    return ElevatedButton(
      onPressed: () async {
        final result = await Navigator.pushNamed(context, '/payment');
        if (result == true) {
          _loadSampleData(); // Reload data after successful payment
        }
      },
      child: const Text('Make a Payment'),
    );
  }
}
