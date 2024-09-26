import 'package:flutter/material.dart';
import 'package:login_signup_page/Chats_Notification_Profile/NotificationScreen.dart';
import 'package:login_signup_page/Chats_Notification_Profile/ProfileScreen.dart';
import 'package:login_signup_page/Lists/chatsList.dart';
import 'package:login_signup_page/Routes/Routes.dart';
import 'package:login_signup_page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreenPage extends StatefulWidget {
  static const String id = 'chat_Screen';
  const ChatScreenPage({super.key});

  @override
  State<ChatScreenPage> createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  int _selectedIndex = 0;
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
      email = prefs.getString('email')!;
      name = prefs.getString('name') ?? 'Unknown Name';
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
    // This clears all saved preferences including login status
    Navigator.pushReplacementNamed(
        context, loginPageScreen.id); // Navigate back to login screen
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });
    Navigator.pushNamed(context,
        routes[index]); // Navigate to the selected screen using named routes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              // currentAccountPictureSize: Size(50, 50),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(
                  name![0].toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              accountName: Text(
                name!,
                style: const TextStyle(fontSize: 20),
              ),
              accountEmail: Text(email!, style: TextStyle(fontSize: 12)),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ProfilePageScreen.id);
              },
              leading: const Icon(Icons.supervised_user_circle_sharp),
              title: const Text("Profile"),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, NotificationPage.id);
              },
              leading: const Icon(Icons.notifications),
              title: const Text("Notification"),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ChatScreenPage.id);
              },
              leading: const Icon(Icons.chat_outlined),
              title: const Text("Chats"),
            ),
            ListTile(
              onTap: () {
                _logout();
                Navigator.pushNamed(context, loginPageScreen.id);
              },
              leading: const Icon(Icons.logout),
              title: const Text("Log Out"),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                nameList[index][0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              nameList[index],
              style: const TextStyle(fontSize: 17),
            ),
            subtitle: Text(
              msgsList[index],
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: Text(timeList[index]),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_outlined,
            ),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_active,
            ),
            label: "Notification",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.supervised_user_circle,
            ),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
