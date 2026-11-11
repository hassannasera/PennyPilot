import 'package:flutter/material.dart';
import 'models.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({super.key});

  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen> {
  final List<String> categories = [
    'Groceries',
    'Entertainment',
    'Transport',
    'Food & Drinks',
    'Health',
    'Shopping',
  ];
  String selectedCategory = 'Groceries';
  double amount = 50;

  void _save() {
    // Send the new budget back to the Budget screen
    Navigator.pop(
      context,
      Budget(category: selectedCategory, budget: amount, spent: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        leadingWidth: 90,
        title: const Text('Add budget'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton(onPressed: _save, child: const Text('Save')),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            DropdownMenu<String>(
              initialSelection: selectedCategory,
              label: const Text('Category'),
              width: 300,
              dropdownMenuEntries: categories
                  .map((c) => DropdownMenuEntry(value: c, label: c))
                  .toList(),
              onSelected: (value) {
                if (value != null) {
                  setState(() => selectedCategory = value);
                }
              },
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.outlined(
                  onPressed: () {
                    if (amount >= 10) setState(() => amount -= 10);
                  },
                  icon: const Icon(Icons.remove),
                ),
                const SizedBox(width: 24),
                Text('\$${amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 36, fontWeight: FontWeight.bold)),
                const SizedBox(width: 24),
                IconButton.outlined(
                  onPressed: () => setState(() => amount += 10),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Monthly budget amount',
                style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
