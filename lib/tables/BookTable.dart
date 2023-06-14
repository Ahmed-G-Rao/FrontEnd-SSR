import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:serves/tables/table_model.dart';
import 'package:http/http.dart' as http;
import 'package:serves/widgets/global_variable.dart';

class BookTableScreen extends StatefulWidget {
  const BookTableScreen({Key? key}) : super(key: key);

  @override
  _BookTableScreenState createState() => _BookTableScreenState();
}

class _BookTableScreenState extends State<BookTableScreen> {
  Future<TablesModel> fetchData() async {
    final response = await http.get(Uri.parse('$baseUrl/GetAllTables'));
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200) {
      return TablesModel.fromJson(data);
    } else {
      return TablesModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Table'),
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(backgroundColor: Colors.amber),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      snapshot.data!.data![index].tableName.toString(),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Capacity: ${snapshot.data!.data![index].capacity.toString()}',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
