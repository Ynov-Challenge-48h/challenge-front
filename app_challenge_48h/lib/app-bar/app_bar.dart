import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60.0); 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: AppColors.whiteBg,
          // elevation: 0, // Remove shadow
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.orangeBorder, width: 2),
                ),
                child: const Icon(Icons.arrow_back, color: AppColors.gray),
              ),
            ),
          ),
          title: Image.asset(
            'assets/logo.png',
            height: 50, 
          ),
          centerTitle: true,
        ),
        Container(
          height: 1.5, 
          width: double.infinity,
          color: AppColors.orangeBorder, 
        ),
      ],
    );
  }
}
