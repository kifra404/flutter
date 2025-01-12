import 'package:flutter/material.dart';
import 'package:ded/widgets/appbar.dart';
import 'package:ded/models/user.dart';
import 'package:ded/models/person.dart';
import 'package:ded/widgets/friend.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _editField(String field, dynamic currentValue) {
    TextEditingController controller = TextEditingController(
      text: field == 'interests'
          ? currentUser.interests.join(', ')
          : currentValue.toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $field'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter new $field',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                switch (field) {
                  case 'name':
                    currentUser.name = controller.text;
                    break;
                  case 'school':
                    currentUser.school = controller.text;
                    break;
                  case 'currentLocation':
                    currentUser.currentLocation = controller.text;
                    break;
                  case 'interests':
                    currentUser.interests = controller.text
                        .split(',')
                        .map((e) => e.trim())
                        .where((e) => e.isNotEmpty)
                        .toList();
                    break;
                  case 'timeSpent':
                    currentUser.timeSpent = controller.text;
                    break;
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(isHomeScreen: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Photo with edit button
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(currentUser.photoUrl),
                    ),
                  ),
                  Positioned(
                    right: 100,
                    bottom: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 20,
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          // TODO: Implement photo change functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Photo edit coming soon')),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Name with edit button
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentUser.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _editField('name', currentUser.name),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Current Location
              _buildEditableContainer(
                icon: Icons.location_on,
                title: 'Current Location',
                value: currentUser.currentLocation,
                onEdit: () =>
                    _editField('currentLocation', currentUser.currentLocation),
              ),

              // School
              _buildEditableContainer(
                icon: Icons.school,
                title: 'School',
                value: currentUser.school,
                onEdit: () => _editField('school', currentUser.school),
              ),

              // Interests
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Interests',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _editField('interests', currentUser.interests),
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: 8,
                      children: currentUser.interests
                          .map((interest) => Chip(
                                label: Text(interest),
                                backgroundColor: Colors.blue[100],
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Time Spent
              _buildEditableContainer(
                icon: Icons.timer,
                title: 'Time Spent in Current Location',
                value: currentUser.timeSpent,
                onEdit: () => _editField('timeSpent', currentUser.timeSpent),
              ),

              // Friends Count (non-editable)
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.people, color: Colors.blue),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Friends',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '${currentUser.friends.length} friends',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(currentIndex: 0),
    );
  }

  Widget _buildEditableContainer({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onEdit,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
          ],
        ),
      ),
    );
  }
}
