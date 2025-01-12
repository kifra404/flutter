import 'package:flutter/material.dart';
import 'package:ded/widgets/appbar.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(isHomeScreen: false),
      body: const Center(
        child: Text('Events Screen'),
      ),
      bottomNavigationBar: BottomBar(currentIndex: 2),
    );
  }
}
