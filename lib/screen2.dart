import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text(
          'Alarm Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}