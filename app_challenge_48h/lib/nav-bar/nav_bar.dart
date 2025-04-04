import 'package:app_challenge_48h/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.orangeBorder, width: 1.5),
        ),
      ),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: AppColors.orangeBorder,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: AppColors.whiteBg,
      ),
    );
  }
}
