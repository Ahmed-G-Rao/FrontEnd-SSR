import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:serves/term_and_conditions/terms_model.dart';
import 'package:serves/widgets/global_variable.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  Future<TermsAndConditions> fetchAllData() async {
    final response =
        await http.get(Uri.parse('$baseUrl/GetTermsAndConditions'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return TermsAndConditions.fromJson(data);
    } else {
      return TermsAndConditions.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: FutureBuilder<TermsAndConditions>(
        future: fetchAllData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          const heading =
              'Welcome to SmartServer Restaurant! Please read these terms and conditions carefully before using our app.';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  heading,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final numberCount = (index + 1).toString();
                    return Container(
                      padding: const EdgeInsets.all(12.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$numberCount. ${snapshot.data!.data![index].description}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
