//bta3tina  ya3ne widgets mtl Scaffold, Text, Column, Button...
import 'package:flutter/material.dart';
// bta3tina awal screen bada tbayin
import 'budget_screen.dart';


void main() {
  runApp(const MyApp());
}

// StatelessWidget: mafi data btt8ayar sebti toul l wa2t
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp hawne l design lal app
    return MaterialApp(
      title: 'PennyPilot',
      // btma7e red "DEBUG" banner
      debugShowCheckedModeBanner: false,
      // theme bta3mil control la colshe design w colors
      theme: ThemeData(
        // Flutter bya3mil color palette mn hayde one green color
        colorSchemeSeed: const Color(0xFF1FAF7A),
        // Use the newer Material 3 design
        useMaterial3: true,
      ),
      // home heyi awal screen btbayin bl app
      home: const BudgetScreen(),
    );
  }
}
