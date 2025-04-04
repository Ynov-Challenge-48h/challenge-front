import 'dart:io'; 
import 'package:app_challenge_48h/app-bar/app_bar.dart';
import 'package:app_challenge_48h/scan-cni/scan_cni.dart';
import 'package:app_challenge_48h/theme/app_colors.dart';
import 'package:app_challenge_48h/nav-bar/nav_bar.dart';
import 'package:flutter/material.dart';

class ClientInfoPage extends StatefulWidget {
  const ClientInfoPage({super.key});

  @override
  _ClientInfoPageState createState() => _ClientInfoPageState();
}

class _ClientInfoPageState extends State<ClientInfoPage> {
  // temp data for tests
  final client = {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'phone': '+1234567890',
  };

  // to store image paths
  String? clientImagePath1;
  String? clientImagePath2;

  @override
  Widget build(BuildContext context) {
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

            // 1st placeholder
            clientImagePath1 == null
                ? Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text('Client Image 1 Placeholder'),
                    ),
                  )
                : Image.file(
                    File(clientImagePath1!), // displays img 1
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),

            const SizedBox(height: 16),

            // 2nd placeholder
            clientImagePath2 == null
                ? Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text('Client Image 2 Placeholder'),
                    ),
                  )
                : Image.file(
                    File(clientImagePath2!),
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),

            const Spacer(),

            // btn 1
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  // go to camera page -> get the image path
                  final imagePath = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );

                  // if picture is taken updates the first image path and refresh UI
                  if (imagePath != null) {
                    setState(() {
                      clientImagePath1 = imagePath;
                    });
                  }
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Scan Card 1"),
              ),
            ),

            const SizedBox(height: 16),

            // btn 2
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final imagePath = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );

                  if (imagePath != null) {
                    setState(() {
                      clientImagePath2 = imagePath;
                    });
                  }
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Scan Card 2"),
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
