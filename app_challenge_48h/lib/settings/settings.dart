import 'package:app_challenge_48h/login/login.dart';
import 'package:app_challenge_48h/nav-bar/nav_bar.dart'; // Make sure Navbar is imported
import 'package:app_challenge_48h/app-bar/app_bar.dart'; // Custom AppBar
import 'package:app_challenge_48h/theme/app_colors.dart'; // Import AppColors for custom colors
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: AppColors.orangeBorder, width: 2), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), 
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: AppColors.orangeBorder,
                ),
              ),
              child: const Text('Disconnect'),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Navbar(),
      backgroundColor: AppColors.whiteBg, 
    );
  }
}
