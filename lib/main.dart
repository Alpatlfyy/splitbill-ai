import 'package:flutter/material.dart';
import 'package:splitbill_ai/features/dashboard/screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SplitBill AI',
      home: const DashboardScreen(),
    );
  }
}