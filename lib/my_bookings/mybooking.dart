import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:serves/my_bookings/mybooking_mode.dart';
import 'package:serves/widgets/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
  }

  Future<MyBookingModel> getBookings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("id");
    final response = await http.post(
        Uri.parse('http://ssr.coderouting.com/GetOrderByUserId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "user_id": userId,
        }));
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200) {
      return MyBookingModel.fromJson(data);
    } else {
      return MyBookingModel.fromJson(data);
    }
  }

  Future<void> cancelOrder(String orderId) async {
    // Perform the cancellation logic here using the order_id
    // For example, you can make an API call to cancel the order
    final response = await http.post(
      Uri.parse('http://ssr.coderouting.com/CancelOrder'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "order_id": orderId,
      }),
    );

    if (response.statusCode == 200) {
      // Order cancellation successful
      print('Order cancelled successfully');
    } else {
      // Order cancellation failed
      print('Failed to cancel order');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      body: FutureBuilder(
        future: getBookings(),
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
              child: Text('You Do Not Have Any Bookings'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final booking = snapshot.data!.data![index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Table Name: ${booking.tableId}',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Order Details: ${booking.orderDetails}',
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Ordered Date: ${booking.orderedAt}',
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Amount: \$${booking.amount}',
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Status: ${booking.status}',
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        cancelOrder(booking.orderId.toString()); // Pass order_id to the cancelOrder function
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
