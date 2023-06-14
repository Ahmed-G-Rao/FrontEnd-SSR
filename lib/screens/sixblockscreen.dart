import 'package:flutter/material.dart';

class SixBlocksScreen extends StatelessWidget {
  const SixBlocksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Six Blocks Screen'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(child: Block()),
                  SizedBox(width: 16.0),
                  Expanded(child: Block()),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(child: Block()),
                  SizedBox(width: 16.0),
                  Expanded(child: Block()),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(child: Block()),
                  SizedBox(width: 16.0),
                  Expanded(child: Block()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Block extends StatelessWidget {
  const Block({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 100.0,
      child: const Center(
        child: Text(
          'Block',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
