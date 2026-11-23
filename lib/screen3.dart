import 'package:flutter/material.dart';

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'Business Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}