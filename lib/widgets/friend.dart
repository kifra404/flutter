import 'package:flutter/material.dart';
import 'package:ded/widgets/appbar.dart';
import 'package:ded/models/person.dart';
import 'package:ded/data/friends_data.dart';

//Contains: Friend, FriendProfileScreen, FriendRow and the friend dummy data

class Friend extends Person {
  final DateTime friendsSince;

  Friend({
    required super.photoUrl,
    required super.name,
    required super.currentLocation,
    required super.school,
    required super.interests,
    required super.timeSpent,
    required this.friendsSince,
  });

  // Factory method to create a Friend from a Person
  factory Friend.fromPerson(Person person) {
    return Friend(
      photoUrl: person.photoUrl,
      name: person.name,
      currentLocation: person.currentLocation,
      school: person.school,
      interests: person.interests,
      timeSpent: person.timeSpent,
      friendsSince: DateTime.now(),
    );
  }
}

class FriendProfileScreen extends StatelessWidget {
  final Friend friend;

  const FriendProfileScreen({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(friend.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          // Add remove friend button
          IconButton(
            icon: const Icon(Icons.person_remove),
            color: Colors.red,
            onPressed: () {
              // Show confirmation dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Remove Friend'),
                    content: Text(
                        'Are you sure you want to remove ${friend.name} from your friends?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Remove',
                            style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          friends.removeWhere((f) => f.name == friend.name);
                          Navigator.of(context).pop(); // Close dialog
                          Navigator.of(context).pop(); // Return to friends list
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Photo
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(friend.photoUrl),
              ),
            ),
            SizedBox(height: 20),
            // Name and Location
            Text(
              friend.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Location: ${friend.currentLocation}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // School
            Text(
              'School: ${friend.school}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Interests
            Text(
              'Interests: ${friend.interests.join(', ')}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Time Spent in Location
            Text(
              'Time spent in ${friend.currentLocation}: ${friend.timeSpent}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          BottomBar(currentIndex: -1), // You can customize the bottom bar
    );
  }
}

class FriendRow extends StatelessWidget {
  final Friend friend;
  final VoidCallback? onTap;

  const FriendRow({
    super.key,
    required this.friend,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FriendProfileScreen(friend: friend),
              ),
            );
          },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            // Profile Photo Column
            Padding(
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(friend.photoUrl),
              ),
            ),
            // Name and Location Column
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      friend.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      friend.currentLocation,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
