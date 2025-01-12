import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHomeScreen;

  TopBar({required this.isHomeScreen});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Image.asset(
        'lib/assets/images/Molecule Top Bar to Main Menu.png',
        fit: BoxFit.cover,
      ),
      leading: isHomeScreen
          ? null
          : IconButton(
              icon: Image.asset(
                'lib/assets/images/Atom back icon.png',
                width: 24,
                height: 24,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
      centerTitle: true,
      title: GestureDetector(
        onTap: () {
          if (!isHomeScreen) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
          }
        },
        child: Text(
          'MyNTUA Life',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}

class BottomBar extends StatelessWidget {
  final int currentIndex;

  BottomBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index != -1) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/profile');
              break;
            case 1:
              Navigator.pushNamed(context, '/friends');
              break;
            case 2:
              Navigator.pushNamed(context, '/events_home');
              break;
          }
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/assets/images/Molecule Menu bar Button Profile.png',
            width: 30,
            height: 30,
          ),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/assets/images/Molecule Menu bar Button Friends.png',
            width: 30,
            height: 30,
          ),
          label: 'Friends',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/assets/images/Molecule Menu bar Button Events.png',
            width: 30,
            height: 30,
          ),
          label: 'Events',
        ),
      ],
    );
  }
}
