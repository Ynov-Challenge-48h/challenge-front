import 'package:app_challenge_48h/client_listing/client_listing.dart';
import 'package:app_challenge_48h/nav-bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_challenge_48h/app-bar/app_bar.dart';
import 'package:app_challenge_48h/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Challenge 48h',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ClientListScreen(),
    );
  }
}
