import 'package:flutter/material.dart';
import 'package:login_signup_page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePageScreen extends StatefulWidget {
  static const String id = 'Profile_Page';
  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  String? email = ' ';
  String? name = ' ';
  @override
  void initState() {
    _loadLoginDetails();
    super.initState();
  }

  Future<void> _loadLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      name = prefs.getString('name');
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs
        .clear(); // This clears all saved preferences including login status
    Navigator.pushReplacementNamed(
        context, loginPageScreen.id); // Navigate back to login screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blueAccent,
              child: Text(
                name![0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),

            // Username
            Text(
              name!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Email or Bio
            Text(
              email!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),

            // Personal Info Section
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4.0,
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Full Name'),
                subtitle: Text(name!),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4.0,
              child: ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                subtitle: Text(email!),
              ),
            ),
            // Card(
            //   margin: const EdgeInsets.symmetric(vertical: 8.0),
            //   elevation: 4.0,
            //   child: ListTile(
            //     leading: Icon(Icons.phone),
            //     title: Text('Phone'),
            //     subtitle: Text('+1 234 567 890'),
            //   ),
            // ),

            const SizedBox(height: 24),

            // Edit Profile Button

            // Logout Button
            ElevatedButton.icon(
              onPressed: () {
                _logout();
                setState(() {});
                Navigator.pushNamed(context, loginPageScreen.id);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
