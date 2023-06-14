import 'dart:async';

import 'package:flutter/material.dart';

class PaymentTabScreen extends StatefulWidget {
  final String name;
  final String orderId;
  final int tableNumber;
  final List items;

  const PaymentTabScreen({
    Key? key,
    required this.name,
    required this.orderId,
    required this.tableNumber,
    required this.items,
  }) : super(key: key);

  @override
  _PaymentTabScreenState createState() => _PaymentTabScreenState();
}

class _PaymentTabScreenState extends State<PaymentTabScreen> {
  String _selectedPaymentMethod = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SMARTSERVE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'PAYMENT',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          Text(
            'NAME: ${widget.name}',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            'ORDERID: ${widget.orderId}',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            'TABLE NUMBER: ${widget.tableNumber}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          const Text(
            'PAYMENT PENDING',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = widget.items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ITEM ${index + 1}: ${item.name}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Rs. ${item.price.toString()}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'TOTAL AMOUNT',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rs. ${calculateTotalAmount()}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'SELECT PAYMENT METHOD',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPaymentMethodButton('CASH'),
              _buildPaymentMethodButton('CREDIT/DEBIT'),
              _buildPaymentMethodButton('EASYPAISA/JAZZC'),
              _buildPaymentMethodButton('SADAPAY'),
            ],
          ),
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton(
              onPressed:
                  _selectedPaymentMethod.isNotEmpty ? _submitPayment : null,
              child: const Text('SUBMIT'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodButton(String paymentMethod) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedPaymentMethod = paymentMethod;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            _selectedPaymentMethod == paymentMethod ? Colors.green : null,
      ),
      child: Text(paymentMethod),
    );
  }

  int calculateTotalAmount() {
    int totalAmount = 0;
    for (var item in widget.items) {
      // totalAmount += item.price;
      totalAmount += 2;
    }
    return totalAmount;
  }

  void _submitPayment() async {
    // Show loading indicator
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Simulate payment processing for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // Hide loading indicator
    Navigator.pop(context);

    // Show payment success message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          content: const Text('Thank you for your payment.'),
          actions: [
            TextButton(
              onPressed: () {
                // Navigate back to the home screen
                Navigator.popUntil(
                  context,
                  ModalRoute.withName('/'),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
