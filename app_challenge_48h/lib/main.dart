import 'package:flutter/material.dart';
import 'package:app_challenge_48h/app-bar/app_bar.dart';
import 'package:app_challenge_48h/theme/app_colors.dart';
import 'package:app_challenge_48h/client-infos/client_infos.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Hello World',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ClientInfoPage()),
                  );
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Scan Card"),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.whiteBg,
    );
  }
}
