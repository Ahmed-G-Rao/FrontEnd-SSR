import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:serves/screens/login_screen.dart';
import 'package:serves/menu/menu.dart';
import 'package:serves/tables/BookTable.dart';
import 'package:serves/screensbyumer/profile_drawercopy.dart';
import 'package:serves/term_and_conditions/termsandconditions.dart';
import 'package:serves/widgets/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../faqs/FAQS.dart';
import '../my_bookings/mybooking.dart';

import '../reviews/reviews2.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  int? user;
  HomeScreen({super.key, this.user});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? token;
  String name = "";
  late Timer _timer;

  get menu => null;
  @override
  void initState() {
    super.initState();
    //fetchUserData();
    getToken();
    name;
    _timer = Timer.periodic(const Duration(seconds: 120), (timer) {
      print("Token${token!}");
      getToken().then((value) {
        // print(token);
        if (token == null) {
          // Redirect the user to the Login Screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
      });
    });
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    final expirationTime = prefs.getInt("expirationTime") ?? 0;
    if (expirationTime != 0 &&
        DateTime.now().millisecondsSinceEpoch > expirationTime) {
      // Token has expired
      await prefs.remove("token");
      await prefs.remove("expirationTime");
      token = null;
    }
  }

  void nullifyToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    await prefs.remove("token");
    if (token == null) {
      // Redirect the user to the Login Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
      return;
    }
  }

  void fetchUserData() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => MyProfileScreen()));
    final response = await http.get(Uri.parse("{$baseUrl}/${widget.user}"));
    final jsonResponse = json.decode(response.body);
    setState(() {
      name = jsonResponse['data'][0]['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: nullifyToken,
          ),
          // ignore: unnecessary_null_comparison
          if (name != null)
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: fetchUserData,
                child: CircleAvatar(child: Icon(Icons.person)),
              ),
            ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  //BOX 1 BOOK TABLE
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BookTableScreen()));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey,
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.table_chart, size: 50),
                            SizedBox(height: 10),
                            Text('Book Table'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //BOX2 MENU
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const MenuScreen()));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey,
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.restaurant_menu, size: 50),
                            SizedBox(height: 10),
                            Text('Menu'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              //REVIEWS
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ReviewScreen()));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueGrey,
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.rate_review, size: 50),
                              SizedBox(height: 10),
                              Text('Reviews'),
                            ],
                          ),
                        )),
                  ),
                  Expanded(
                      //MYBOOKINGS
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const BookingScreen()));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueGrey,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bookmark, size: 50),
                          SizedBox(height: 10),
                          Text('My Bookings'),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Expanded(
              //TERMS and CONDITIONS
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const TermsAndConditionsScreen()));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blueGrey,
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.description, size: 50),
                                SizedBox(height: 10),
                                Text('T&C'),
                              ],
                            ),
                          ))),
                  Expanded(
                      //FAQS
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const FaqsScreen()));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blueGrey,
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.help, size: 50),
                                SizedBox(height: 10),
                                Text('FAQ'),
                              ],
                            ),
                          ))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
