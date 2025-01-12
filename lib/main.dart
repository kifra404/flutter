import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:ded/presentation/home.dart';
import 'package:ded/presentation/friends.dart';
import 'package:ded/presentation/profile.dart';
import 'package:ded/presentation/events.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Google Maps
    if (defaultTargetPlatform == TargetPlatform.android) {
      final mapsImplementation = GoogleMapsFlutterAndroid();
      await mapsImplementation
          .initializeWithRenderer(AndroidMapRenderer.latest);
    }

    runApp(const MyApp());
  } catch (e) {
    print("Error in main: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color photoThemeColor = Color(0xFF373737); // Photo theme color
  static const Color friendColor = Color(0xFF0529A8); // Friend color
  static const Color eventColor = Color(0xFFB40320); // Event color
  static const Color mainBarColor = Color(0xFF115E72); // Main bar color
  static const Color topBarColor = Color(0xFF721121); // Top bar color
  static const Color textColor = Color(0xFF000000); // Text color

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/friends': (context) => const FriendsScreen(),
        '/events_home': (context) => const EventsScreen(),
      },
      title: 'MyNTUA Life',
      theme: ThemeData(
        primaryColor: mainBarColor,
        appBarTheme: const AppBarTheme(backgroundColor: topBarColor),
      ),
    );
  }
}
