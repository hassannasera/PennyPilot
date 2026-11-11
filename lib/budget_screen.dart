import 'package:flutter/material.dart';
import 'models.dart';
import 'add_budget_screen.dart';
import 'spending_screen.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final List<Budget> budgets = [
    Budget(category: 'Entertainment', budget: 100, spent: 45),
    Budget(category: 'Transport', budget: 80, spent: 20),
    Budget(category: 'Food & Drinks', budget: 250, spent: 120),
  ];

  double get totalBudget => budgets.fold(0, (sum, b) => sum + b.budget);
  double get totalSpent => budgets.fold(0, (sum, b) => sum + b.spent);

  Future<void> _openAddScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddBudgetScreen()),
    );
    if (result != null && result is Budget) {
      setState(() {
        budgets.add(result); // add items at runtime to the ListView
      });
    }
  }

  void _openSpendingScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SpendingScreen(totalSpent: totalSpent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress =
    totalBudget == 0 ? 0.0 : (totalSpent / totalBudget).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(title: const Text('Budget')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Spending card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0B2B22),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Spending',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFF1FAF7A),
                    backgroundColor: Colors.white24,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '\$${totalSpent.toStringAsFixed(0)} spent of '
                        '\$${totalBudget.toStringAsFixed(0)} budgeted',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Bills and Earnings cards
            Row(
              children: const [
                Expanded(child: InfoCard(title: 'Bills', value: '\$100')),
                SizedBox(width: 12),
                Expanded(child: InfoCard(title: 'Earnings', value: '\$500')),
              ],
            ),
            const SizedBox(height: 12),
            // Buttons
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _openAddScreen,
                  icon: const Icon(Icons.add),
                  label: const Text('Add budget'),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _openSpendingScreen,
                  icon: const Icon(Icons.pie_chart),
                  label: const Text('Spending'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Budget category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            // Category list
            Expanded(
              child: ListView.builder(
                itemCount: budgets.length,
                itemBuilder: (context, index) {
                  final b = budgets[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.category),
                      title: Text(b.category),
                      subtitle: Text('\$${b.spent.toStringAsFixed(0)} spent'),
                      trailing:
                      Text('\$${b.budget.toStringAsFixed(0)} budget'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom widget class (reused for Bills and Earnings)
class InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const InfoCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF5F1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 4),
          Text(value,
              style:
              const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
