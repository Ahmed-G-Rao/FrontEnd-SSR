// ignore_for_file: dead_code
import 'package:serves/ScreensByAhmed/Home.dart';
import 'package:serves/screens/signup_screen.dart';
import 'package:serves/widgets/customized_textfield.dart';
import 'package:flutter/material.dart';
import 'package:serves/widgets/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/customized_button.dart';
import 'forgot_passwor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? token;
  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );
      final jsonResponse = json.decode(response.body);
      final status = jsonResponse['status'];
      final userId = jsonResponse['id'];

      if (status == 200) {
        token = json.decode(response.body)['token'] as String;

        SharedPreferences prefs = await SharedPreferences.getInstance();

        final expirationTime = DateTime.now().millisecondsSinceEpoch +
            1200000; //CHANGE KARNA HA ISKO
        await prefs.setString('token', token!);

        await prefs.setInt("expirationTime", expirationTime);

        await prefs.setInt('id', userId); // Store the "id" in SharedPreferences

        Set<String> keys = prefs.getKeys();
        for (String key in keys) {
          dynamic value = prefs.get(key);
          print('HIII$key: $value');
        }

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(user: userId)),
            (route) => true);

        setState(() {
          token = token;
        });
      } else if (status == 401) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Email not Verified"),
            actions: [
              Center(
                child: ElevatedButton(
                  child: const Text("Close"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      } else if (status == 400) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Invalid Username or password"),
            actions: [
              Center(
                child: ElevatedButton(
                  child: const Text("Close"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid Username or password"),
          actions: [
            Center(
              child: ElevatedButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_sharp),
                      onPressed: () {
                        // Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SignUpScreen()));
                      }),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Welcome Back! Glad \nto see you again",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              CustomizedTextfield(
                myController: _emailController,
                hintText: "Enter your Email",
                isPassword: false,
              ),
              CustomizedTextfield(
                myController: _passwordController,
                hintText: "Enter your Password",
                isPassword: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPassword()));
                    },
                    child: const Text("Forgot Password?",
                        style: TextStyle(
                          color: Color(0xff6A707C),
                          fontSize: 15,
                        )),
                  ),
                ),
              ),
              CustomizedButton(
                  buttonText: "Login",
                  buttonColor: Colors.black,
                  textColor: Colors.white,
                  onPressed: _handleLogin),
              Padding(
                padding: const EdgeInsets.fromLTRB(48, 8, 8, 8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Color(0xff1E232C),
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: const Text(
                        "  Register Now",
                        style: TextStyle(
                          color: Color(0xff35C2C1),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
