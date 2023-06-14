import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../screens/login_screen.dart';
import '../widgets/global_variable.dart';

class OTPScreen extends StatefulWidget {
  String? email;
  OTPScreen({super.key, this.email});

  @override
  // ignore: library_private_types_in_public_api
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();
  final TextEditingController _fourthController = TextEditingController();
  final TextEditingController _fifthController = TextEditingController();

  final FocusNode _firstFocusNode = FocusNode();
  final FocusNode _secondFocusNode = FocusNode();
  final FocusNode _thirdFocusNode = FocusNode();
  final FocusNode _fourthFocusNode = FocusNode();
  final FocusNode _fifthFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _firstFocusNode.addListener(() {
      if (_firstFocusNode.hasFocus) {
        _firstController.clear();
      }
    });

    _secondFocusNode.addListener(() {
      if (_secondFocusNode.hasFocus) {
        _secondController.clear();
      }
    });

    _thirdFocusNode.addListener(() {
      if (_thirdFocusNode.hasFocus) {
        _thirdController.clear();
      }
    });

    _fourthFocusNode.addListener(() {
      if (_fourthFocusNode.hasFocus) {
        _fourthController.clear();
      }
    });

    _fifthFocusNode.addListener(() {
      if (_fifthFocusNode.hasFocus) {
        _fifthController.clear();
      }
    });
  }

  void _submitOTP() async {
    try {
      String otp =
          "${_firstController.text}${_secondController.text}${_thirdController.text}${_fourthController.text}${_fifthController.text}";
      int intOTP = int.parse(otp);
      print(widget.email);
      print(otp);
      final response = await http.post(Uri.parse("${baseUrl}/OTP"),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'email': widget.email, 'OTP': intOTP}));
      final jsonRespone = json.decode(response.body);
      final status = jsonRespone['status'];
      if (status == 200) {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  title: const Text("Account Verified!"),
                  actions: [
                    Center(
                        child: ElevatedButton(
                      child: const Text("Login"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                // ignore: prefer_const_constructors
                                builder: (context) => LoginScreen()));
                      },
                    ))
                  ],
                )));
      } else if (status == 400) {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  title: const Text("Invalid OTP!"),
                  actions: [
                    Center(
                        child: ElevatedButton(
                      child: const Text("Close"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ))
                  ],
                )));
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: const Text("Something Went Wrong, Try Again Later!"),
                actions: [
                  Center(
                      child: ElevatedButton(
                    child: const Text("Close"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ))
                ],
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: TextField(
                    controller: _firstController,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    focusNode: _firstFocusNode,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1) {
                        _secondFocusNode.requestFocus();
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: TextField(
                    controller: _secondController,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    focusNode: _secondFocusNode,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1) {
                        _thirdFocusNode.requestFocus();
                      } else if (value.isEmpty) {
                        _firstFocusNode.requestFocus();
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: TextField(
                    controller: _thirdController,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    focusNode: _thirdFocusNode,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1) {
                        _fourthFocusNode.requestFocus();
                      } else if (value.isEmpty) {
                        _secondFocusNode.requestFocus();
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: TextField(
                    controller: _fourthController,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    focusNode: _fourthFocusNode,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1) {
                        _fifthFocusNode.requestFocus();
                      } else if (value.isEmpty) {
                        _thirdFocusNode.requestFocus();
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: TextField(
                    controller: _fifthController,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    focusNode: _fifthFocusNode,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        _fourthFocusNode.requestFocus();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _submitOTP,
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
