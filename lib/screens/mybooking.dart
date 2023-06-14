import 'dart:async';
import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  final int tableNumber;
  final int timeRemainingInMinutes;

  const BookingScreen({super.key, required this.tableNumber, required this.timeRemainingInMinutes});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late Timer _timer;
  late int _currentTimeRemainingInSeconds;

  @override
  void initState() {
    super.initState();
    _currentTimeRemainingInSeconds = widget.timeRemainingInMinutes * 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentTimeRemainingInSeconds > 0) {
          _currentTimeRemainingInSeconds--;
        } else {
          _timer.cancel();
          // Perform action when time is up
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _currentTimeRemainingInSeconds ~/ 60;
    int seconds = _currentTimeRemainingInSeconds % 60;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Table ${widget.tableNumber}',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Time Remaining:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$minutes:${seconds.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Perform action when cancel button is pressed
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
