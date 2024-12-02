import 'package:flutter/material.dart';
import 'dart:async';

class CountdownClock extends StatefulWidget {
  final DateTime targetTime; // Target time for the countdown

  const CountdownClock({Key? key, required this.targetTime}) : super(key: key);

  @override
  _CountdownClockState createState() => _CountdownClockState();
}

class _CountdownClockState extends State<CountdownClock> {
  late Duration _remainingTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateRemainingTime();
    _startTimer();
  }

  void _updateRemainingTime() {
    final now = DateTime.now();
    setState(() {
      _remainingTime = widget.targetTime.difference(now);
      if (_remainingTime.isNegative) {
        _remainingTime = Duration.zero;
        _showEventOngoingDialog(); // Show popup when countdown ends
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateRemainingTime();
      if (_remainingTime == Duration.zero) {
        _timer.cancel();
      }
    });
  }

  void _showEventOngoingDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Event Ongoing'),
            content: const Text('The event is now live. Enjoy!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_remainingTime == Duration.zero) {
      return const SizedBox(); // Hide countdown when event is ongoing
    }

    final days = _remainingTime.inDays.toString().padLeft(2, '0');
    final hours = (_remainingTime.inHours % 24).toString().padLeft(2, '0');
    final minutes = (_remainingTime.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_remainingTime.inSeconds % 60).toString().padLeft(2, '0');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTimeBox(context, days, 'Days'),
        const SizedBox(width: 15),
        _buildTimeBox(context, hours, 'Hours'),
        const SizedBox(width: 15),
        _buildTimeBox(context, minutes, 'Minutes'),
        const SizedBox(width: 15),
        _buildTimeBox(context, seconds, 'Seconds'),
      ],
    );
  }

  // Helper function to create individual time boxes
  Widget _buildTimeBox(BuildContext context, String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
