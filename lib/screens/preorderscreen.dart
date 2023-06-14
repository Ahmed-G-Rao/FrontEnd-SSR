import 'dart:async';

import 'package:flutter/material.dart';

class PreorderStatusScreen extends StatefulWidget {
  final String orderId;
  final int tableNumber;
  final DateTime checkInTime;

  const PreorderStatusScreen({
    Key? key,
    required this.orderId,
    required this.tableNumber,
    required this.checkInTime,
  }) : super(key: key);

  @override
  _PreorderStatusScreenState createState() => _PreorderStatusScreenState();
}

class _PreorderStatusScreenState extends State<PreorderStatusScreen> {
  late Timer _timer;
  int _timeRemaining = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
  final startTime = widget.checkInTime;
  final now = DateTime.now();
  final durationInMinutes = now.difference(startTime).inMinutes;
  _timeRemaining = 10 - durationInMinutes;

  _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
    setState(() {
      _timeRemaining = _timeRemaining - 1;
    });

    if (_timeRemaining <= 0) {
      timer.cancel();
    }
  });
}


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Order ID: ${widget.orderId}',
              style: TextStyle(fontSize: screenWidth * 0.08),
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              'Table Number: ${widget.tableNumber}',
              style: TextStyle(fontSize: screenWidth * 0.06),
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              'Time Remaining: $_timeRemaining Mintues',
              style: TextStyle(fontSize: screenWidth * 0.06),
            ),
          ],
        ),
      ),
    );
  }
}

