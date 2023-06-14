import 'package:flutter/material.dart';

class BookTableScreen extends StatefulWidget {
  const BookTableScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookTableScreenState createState() => _BookTableScreenState();
}

class _BookTableScreenState extends State<BookTableScreen> {
  String selectedTable = 'Table 1';
  late TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Table'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[300],
              child: const Center(
                child: Text('Map Placeholder'),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Select Table',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTableButton('Table 1'),
              _buildTableButton('Table 2'),
              _buildTableButton('Table 3'),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Select Time',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _showTimePicker(),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedTime == null
                        ? 'Select Time'
                        : selectedTime.format(context),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Icon(Icons.access_time),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Confirm Booking'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            child: const Text('See Menu'),
          ),
        ],
      ),
    );
  }

  Widget _buildTableButton(String table) {
    final isSelected = table == selectedTable;

    return ElevatedButton(
      onPressed: () => setState(() => selectedTable = table),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (isSelected) {
              return const Color.fromARGB(255, 10, 204, 20);
            } else {
              return const Color.fromARGB(255, 143, 135, 135);
            }
          },
        ),
      ),
      child: Text(table),
    );
  }

  Future<void> _showTimePicker() async {
    final now = TimeOfDay.now();

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime = now,
    );

    if (pickedTime != null) {
      setState(() => selectedTime = pickedTime);
    }
  }
}
