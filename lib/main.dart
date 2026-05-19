import 'package:flutter/material.dart';
import 'package:splitbill_ai/widgets/bottom_nav_shell.dart';

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
      home: const BottomNavShell(),
    );
  }
}