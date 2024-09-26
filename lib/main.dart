import 'package:flutter/material.dart';
import 'package:login_signup_page/Chats_Notification_Profile/ChatsScreen.dart';
import 'package:login_signup_page/Chats_Notification_Profile/NotificationScreen.dart';
import 'package:login_signup_page/Chats_Notification_Profile/ProfileScreen.dart';
import 'package:login_signup_page/login_page.dart';
import 'package:login_signup_page/signUp_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  print(isLoggedIn);
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // initialRoute: isLoggedIn ? loginPageScreen.id : ChatScreenPage.id,
      initialRoute: loginPageScreen.id,
      routes: {
        loginPageScreen.id: (context) => const loginPageScreen(),
        signUpPageScreen.id: (context) => const signUpPageScreen(),
        ChatScreenPage.id: (context) => const ChatScreenPage(),
        NotificationPage.id: (context) => NotificationPage(),
        ProfilePageScreen.id: (context) => ProfilePageScreen(),
      },
    );
  }
}
