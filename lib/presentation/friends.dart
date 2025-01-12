import 'package:flutter/material.dart';
import 'package:ded/widgets/appbar.dart';
import 'package:ded/widgets/friend.dart';
import 'package:ded/models/person.dart';
import 'package:ded/models/user.dart';
import 'package:ded/data/persons_data.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  String searchQuery = '';
  List<Person> searchResults = [];

  void searchPeople(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        searchResults = [];
      } else {
        searchResults = persons
            .where((person) =>
                person.name.toLowerCase().contains(query.toLowerCase()) &&
                !currentUser.friends
                    .any((friend) => friend.name == person.name))
            .toList();
      }
    });
  }

  void addFriend(Person person) {
    setState(() {
      currentUser.friends.add(Friend.fromPerson(person));
      searchResults.remove(person);
      searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(isHomeScreen: false),
      body: Column(
        children: [
          // Molecule Bar Image
          Image.asset(
            'lib/assets/images/Molecule Bar Friends.png',
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for people...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              onChanged: searchPeople,
            ),
          ),
          // Search Results
          if (searchResults.isNotEmpty)
            Container(
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Search Results',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ...searchResults.map((person) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(person.photoUrl),
                        ),
                        title: Text(person.name),
                        subtitle: Text(person.school),
                        trailing: IconButton(
                          icon: const Icon(Icons.person_add),
                          onPressed: () => addFriend(person),
                        ),
                      )),
                ],
              ),
            ),
          // Friends List
          Expanded(
            child: ListView.builder(
              itemCount: currentUser.friends.length,
              itemBuilder: (context, index) {
                final friend = currentUser.friends[index];
                return FriendRow(
                  friend: friend,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FriendProfileScreen(friend: friend),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(currentIndex: 1),
    );
  }
} // FriendsScreen widget
