import 'package:flutter/material.dart';
import 'package:serves/widgets/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyProfileScreen extends StatefulWidget {
  @override
  State<MyProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<MyProfileScreen> {
  String? userId;
  String? userName;
  String? userEmail;
  String? userContact;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId");
    if (userId != null) {
      final response = await http.post(
        Uri.parse('http://ssr.coderouting.com/GetUserProfileById'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'user_id': userId}),
      );
      final jsonResponse = json.decode(response.body);
      print("Response: $jsonResponse");
      setState(() {
        userName = jsonResponse['name'];
        userEmail = jsonResponse['email'];
        userContact = jsonResponse['phone_number'];
        _nameController.text = userName ?? '';
        _emailController.text = userEmail ?? '';
        _contactController.text = userContact ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
        backgroundColor: Color(0xFF800000),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('images/avatar.png'),
            ),
            SizedBox(height: 20),
            Text(
              userName ?? '',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            buildTextField(
              _nameController,
              'Name',
              userName ?? '',
              isEditMode,
            ),
            SizedBox(height: 20),
            Text(
              userEmail ?? '',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            buildTextField(
              _emailController,
              'Email',
              userEmail ?? '',
              isEditMode,
            ),
            SizedBox(height: 20),
            Text(
              userContact ?? '',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            buildTextField(
              _contactController,
              'Contact Number',
              userContact ?? '',
              isEditMode,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isEditMode = !isEditMode;
                  });
                },
                child: Text(isEditMode ? 'Save' : 'Edit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label,
      String value, bool isEditable) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        enabled: isEditable,
      ),
      enabled: isEditable,
      onChanged: (text) {
        setState(() {
          value = text;
        });
      },
    );
  }
}
