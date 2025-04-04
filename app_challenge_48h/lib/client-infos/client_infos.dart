import 'package:app_challenge_48h/app-bar/app_bar.dart';
import 'package:app_challenge_48h/scan-cni/scan_cni.dart';
import 'package:app_challenge_48h/theme/app_colors.dart';
import 'package:app_challenge_48h/nav-bar/nav_bar.dart';
import 'package:flutter/material.dart';

class ClientInfoPage extends StatelessWidget {
  const ClientInfoPage({super.key});

  @override
  Widget build(BuildContext context) {

    // temporary data for tests
    final client = {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'phone': '+1234567890',
    };

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Client Info Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${client['name']}"),
                    const SizedBox(height: 8),
                    Text("Email: ${client['email']}"),
                    const SizedBox(height: 8),
                    Text("Phone: ${client['phone']}"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('Client Image Placeholder'),
              ),
            ),

            const Spacer(),

            // Scan Card Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()), // sends to scan-cni
                  );
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Scan Card"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(),
      backgroundColor: AppColors.whiteBg,
    );
  }
}
