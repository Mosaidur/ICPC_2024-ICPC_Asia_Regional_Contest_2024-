import 'package:flutter/material.dart';

class ContestSchedule extends StatelessWidget {
  const ContestSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onsite Contest Schedule'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              "assets/images/3.jpg", // Replace with your local map image
              // height: 00,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30),
            const Text(
              'Friday, December 06, 2024 - Onsite Mock Contest',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),
            _buildScheduleTable([
              ['10:00 AM', '12:00 PM', 'ICPC Asia Dhaka Regional 2024 - Onsite Mock Contest', 'Daffodil Smart City'],
            ]),
            const SizedBox(height: 20),
            const Text(
              'Saturday, December 07, 2024 - Onsite Contest',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),
            _buildScheduleTable([
              ['09:00 AM', '02:00 PM', 'ICPC Asia Dhaka Regional 2024 - Onsite Regional Contest', 'Daffodil Smart City'],
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleTable(List<List<String>> schedule) {
    return Table(
      border: TableBorder.all(color: Colors.grey, width: 1),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(5),
        3: FlexColumnWidth(3),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.blueAccent.withOpacity(0.2)),
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Start', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('End', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Location', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        for (var row in schedule)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(row[0]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(row[1]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(row[2]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(row[3]),
              ),
            ],
          ),
      ],
    );
  }
}
