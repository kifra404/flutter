import 'package:ded/data/friends_data.dart';
import 'package:ded/models/person.dart';
import 'package:ded/widgets/friend.dart';

class User extends Person {
  List<Friend> friends;

  User({
    required super.name,
    required super.currentLocation,
    required super.school,
    required super.interests,
    required super.timeSpent,
    required super.photoUrl,
    required this.friends,
  });

  void addFriend(Friend friend) {
    friends.add(friend);
  }

  void removeFriend(Friend friend) {
    friends.removeWhere((f) => f.name == friend.name);
  }
}

// Create the current user instance
var currentUser = User(
  name: 'Maria',
  currentLocation: 'ECE Cafeteria',
  school: 'ECE',
  interests: ['Physics'],
  timeSpent: '300 hours',
  photoUrl: 'lib/assets/images/Atom Photo Profile.png',
  friends: friends,
);
