// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:serves/tables/table_model.dart';
import 'package:http/http.dart' as http;
import 'package:serves/widgets/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ScreensByAhmed/OrderFood.dart';

class BookTableScreen extends StatefulWidget {
  @override
  _BookTableScreenState createState() => _BookTableScreenState();
}

class _BookTableScreenState extends State<BookTableScreen> {
  TextEditingController searchController = TextEditingController();
  Future<TablesModel>? tablesFuture;
  String? selectedTableId;

  @override
  void initState() {
    super.initState();
    tablesFuture = getTables();
  }

  Future<TablesModel> getTables() async {
    final response = await http.get(Uri.parse('$baseUrl/GetAvailableTables'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return TablesModel.fromJson(data);
    } else {
      throw Exception('Failed to load Tables');
    }
  }

  Future<void> bookTable(int tableId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("id");

    // Implement the logic to book the selected table
    final response = await http.post(Uri.parse('$baseUrl/AddOrder'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "user_id": userId,
          "table_id": tableId,
          "order_details": "",
          "amount": "",
          "status": "Pending"
        }));
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Center(child: Text("Table Booked")),
          content: ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: const Text("Order Food"),
                onPressed: () {
                  Navigator.pop(context); // Close the dialog box
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FoodMenuScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
    print('Table ID: $tableId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Table'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: 'Search by Capacity',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<TablesModel>(
              future: tablesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('No data available'),
                  );
                }

                // Apply the search filter
                final filteredTables = searchController.text.isEmpty
                    ? snapshot.data!.data!
                    : snapshot.data!.data!
                        .where((table) => table.capacity
                            .toString()
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase()))
                        .toList();

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemCount: filteredTables.length,
                    itemBuilder: (BuildContext context, int index) {
                      final table = filteredTables[index];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedTableId ==
                                snapshot.data!.data![index].tableId
                                    .toString()) {
                              // Unselect the table
                              selectedTableId = null;
                            } else {
                              // Select the table
                              selectedTableId = snapshot
                                  .data!.data![index].tableId
                                  .toString();
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFD4D4D4), Color(0xFFFFFFFF)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            border: selectedTableId ==
                                    snapshot.data!.data![index].tableId
                                        .toString()
                                ? Border.all(
                                    color: Colors.blue,
                                    width: 2.0,
                                  )
                                : null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  table.tableName.toString(),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Capacity : ${table.capacity.toString()}',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: selectedTableId != null
                ? () => bookTable(int.parse(selectedTableId!))
                : null,
            child: const Text('Book Table'),
          ),
        ],
      ),
    );
  }
}
