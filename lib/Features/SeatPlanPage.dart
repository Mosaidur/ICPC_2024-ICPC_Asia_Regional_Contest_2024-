import 'package:flutter/material.dart';

// Dummy Pages for Navigation (Now the names are Zone1Page, Zone2Page, etc.)
class ZonePage extends StatelessWidget {
  final String zoneName;

  ZonePage({required this.zoneName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$zoneName Details'),
      ),
      body: Center(
        child: Text(
          'Details for $zoneName',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Main Page with 10 Zones
class SeatPlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Plan'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // You can change this as per your layout needs
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 10, // Number of zones
        itemBuilder: (context, index) {
          // Defining the 10 zones with names and corresponding pages
          final zoneName = 'Zone ${index + 1}'; // Zone names
          return _buildFeatureItem(context, zoneName, ZonePage(zoneName: zoneName));
        },
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue[100],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.event_seat, size: 50, color: Colors.blue), // Default icon for the zones
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy Pages for each Zone (Replace with actual content)
class Zone1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZonePage(zoneName: 'Zone 1');
  }
}

class Zone2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZonePage(zoneName: 'Zone 2');
  }
}

class Zone3Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZonePage(zoneName: 'Zone 3');
  }
}

class Zone4Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZonePage(zoneName: 'Zone 4');
  }
}

class Zone5Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZonePage(zoneName: 'Zone 5');
  }
}

class Zone6Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZonePage(zoneName: 'Zone 6');
  }
}

class Zone7Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZonePage(zoneName: 'Zone 7');
  }
}

class Zone8Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZonePage(zoneName: 'Zone 8');
  }
}

class Zone9Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZonePage(zoneName: 'Zone 9');
  }
}

class Zone10Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZonePage(zoneName: 'Zone 10');
  }
}
