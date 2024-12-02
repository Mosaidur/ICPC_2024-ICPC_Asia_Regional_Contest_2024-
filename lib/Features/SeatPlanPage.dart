import 'package:flutter/material.dart';

class SeatPlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Plan'),
      ),
      body: Center(
        child: Text(
          'Coming Soon',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue, // You can customize the color as per your preference
          ),
        ),
      ),
    );
  }
}
