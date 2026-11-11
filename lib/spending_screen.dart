import 'package:flutter/material.dart';

class SpendingScreen extends StatefulWidget {
  final double totalSpent;

  const SpendingScreen({super.key, required this.totalSpent});

  @override
  State<SpendingScreen> createState() => _SpendingScreenState();
}

class _SpendingScreenState extends State<SpendingScreen> {
  String period = 'Month';
  bool includeBills = true;

  static const double income = 500;
  static const double bills = 100;

  @override
  Widget build(BuildContext context) {
    final total = widget.totalSpent + (includeBills ? bills : 0);
    final net = income - total;
    final progress = (total / income).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(title: const Text('Spending')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Time tabs
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Today', label: Text('Today')),
                ButtonSegment(value: 'Week', label: Text('Week')),
                ButtonSegment(value: 'Month', label: Text('Month')),
                ButtonSegment(value: 'Year', label: Text('Year')),
              ],
              selected: {period},
              onSelectionChanged: (value) =>
                  setState(() => period = value.first),
            ),
            const SizedBox(height: 12),
            // Include bills switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Include bills', style: TextStyle(fontSize: 16)),
                Switch(
                  value: includeBills,
                  onChanged: (v) => setState(() => includeBills = v),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Donut chart
            SizedBox(
              width: 180,
              height: 180,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 18,
                      color: const Color(0xFF1FAF7A),
                      backgroundColor: const Color(0xFFBFE6D3),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Total spend',
                          style: TextStyle(color: Colors.black54)),
                      Text('\$${total.toStringAsFixed(0)}',
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Summary row
            Row(
              children: [
                Expanded(child: _stat('Income', income)),
                const SizedBox(width: 8),
                Expanded(child: _stat('Spending', total)),
                const SizedBox(width: 8),
                Expanded(child: _stat('Net Balance', net)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String label, double value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF5F1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 4),
          Text('\$${value.toStringAsFixed(0)}',
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
