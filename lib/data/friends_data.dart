import 'package:ded/widgets/friend.dart';

final List<Friend> friends = [
  Friend(
    photoUrl: 'lib/assets/images/john.png',
    name: 'John',
    currentLocation: 'NTUA Library',
    school: 'ECE',
    interests: ['Programming', 'AI'],
    timeSpent: '2 hours',
    friendsSince: DateTime.now(),
  ),
  Friend(
    photoUrl: 'lib/assets/images/maria.png',
    name: 'Maria',
    currentLocation: 'ECE Cafeteria',
    school: 'ECE',
    interests: ['Physics', 'Mathematics'],
    timeSpent: '1 hour',
    friendsSince: DateTime.now(),
  ),
  // Add more friends as needed
];
