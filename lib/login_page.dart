import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:login_signup_page/Chats_Notification_Profile/ChatsScreen.dart';
import 'package:login_signup_page/Lists/backgroundImageList.dart';
import 'package:login_signup_page/Utils/animations.dart';
import 'package:login_signup_page/signUp_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginPageScreen extends StatefulWidget {
  static const String id = 'login_Screen';
  const loginPageScreen({super.key});

  @override
  State<loginPageScreen> createState() => _loginPageScreenState();
}

class _loginPageScreenState extends State<loginPageScreen> {
  bool? isChecked = false;
  bool isHover = false;
  int selectedIndex = 0;
  bool showOption = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _saveLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _emailController.text);
    await prefs.setString('password', _passwordController.text);
    await prefs.setBool('isLoggedIn', true);
  }

//validation
  void _handleLogin() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      await _saveLoginDetails();
      Navigator.pushNamed(context, ChatScreenPage.id);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter correct email and password"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 50,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                  child: showOption
                      ? ShowUpAnimation(
                          delay: 100,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: bgImageList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: selectedIndex == index
                                        ? Colors.white
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(1),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage(
                                          bgImageList[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      : const SizedBox()),
              const SizedBox(
                width: 20,
              ),
              showOption
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          showOption = false;
                        });
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      ))
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          showOption = true;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              bgImageList[selectedIndex],
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(bgImageList[selectedIndex]), fit: BoxFit.fill),
        ),
        child: Container(
          width: double.infinity,
          height: 400,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
            color: Colors.black.withOpacity(0.1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Email",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    const Spacer(),
                    Container(
                      height: 35,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white),
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Expanded(
                          child: TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "Password",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Container(
                      height: 35,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white),
                        ),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        // obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Flexible for Checkbox and Text
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.4, // 40% of screen width
                          child: Row(
                            children: [
                              Checkbox(
                                fillColor:
                                    MaterialStatePropertyAll(Colors.white),
                                checkColor: Colors.black,
                                value: isChecked,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    isChecked = newValue;
                                  });
                                },
                                side: BorderSide.none, // No border
                              ),
                              const Expanded(
                                // Wrap the text in an Expanded for flexible width
                                child: Text(
                                  "Remember Me, ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14, // Responsive font size
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Flexible for FORGET PASSWORD
                        Expanded(
                          child: MouseRegion(
                            onEnter: (event) {
                              setState(() {
                                isHover = true;
                              });
                            },
                            onExit: (event) {
                              setState(() {
                                isHover = false;
                              });
                            },
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                // Handle Forget Password tap
                              },
                              child: Text(
                                "FORGET PASSWORD",
                                style: TextStyle(
                                  color: isHover
                                      ? Colors.grey.shade300
                                      : Colors.white,
                                  fontSize: 14, // Responsive font size
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 45,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _handleLogin();
                          }
                        },
                        child: const Center(
                          child: Text(
                            "Log In",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account! ",
                          style: TextStyle(color: Colors.white),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, signUpPageScreen.id);
                            },
                            child: const Text(
                              "SIGN UP",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
