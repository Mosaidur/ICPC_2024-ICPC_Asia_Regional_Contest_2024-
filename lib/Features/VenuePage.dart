import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VenuePage extends StatefulWidget {
  @override
  _VenuePageState createState() => _VenuePageState();
}

class _VenuePageState extends State<VenuePage> {
  // Function to open the map link
  void _openMap() async {
    const mapUrl = 'https://maps.app.goo.gl/H4rpxVtHEyaQUrUn7';
    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the map link')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venue'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Venue Location',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Daffodil International University (DIU)',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Image.asset(
              "assets/images/3.jpg", // Replace with your local map image
              // height: 00,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _openMap,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15), backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Open DIU Map',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
