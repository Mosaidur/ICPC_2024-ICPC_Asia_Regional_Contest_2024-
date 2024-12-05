import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Embedded location data (previous JSON)
const List<Map<String, String>> locationData = [
  {
    "name": "স্বাধীনতা সম্মেলন কেন্দ্র",
    "url": "https://maps.app.goo.gl/FnFtbQr9BV87enqz9",
    "image": "assets/discover_DIU/location1.jpg"
  },
  {
    "name": "International Conference Hall",
    "url": "https://maps.app.goo.gl/KoZ8PfpnUwzuQPg66",
    "image": "assets/discover_DIU/location2.jpg"
  },
  {
    "name": "Food Court",
    "url": "https://maps.app.goo.gl/jVhWaEJsAs2EMrDQ9",
    "image": "assets/discover_DIU/location3.jpg"
  },
  {
    "name": "Green Garden",
    "url": "https://maps.app.goo.gl/foRbnKKvLzRav3Nr9",
    "image": "assets/discover_DIU/location4.jpg"
  },
  {
    "name": "Knowledge Tower (AB4)",
    "url": "https://maps.app.goo.gl/mz11jctBFwuRvy3j7",
    "image": "assets/discover_DIU/location5.jpg"
  },
  {
    "name": "Inspiration Building (AB1)",
    "url": "https://maps.app.goo.gl/SVKw4QS5Tkik54tc9",
    "image": "assets/discover_DIU/location6.jpg"
  },
  {
    "name": "DIU Central Jame Masjid",
    "url": "https://maps.app.goo.gl/xfJEgryG5myLyy3A7",
    "image": "assets/discover_DIU/location7.jpg"
  },
  {
    "name": "DIU Library",
    "url": "https://maps.app.goo.gl/X7ptC5NppQyuftJNA",
    "image": "assets/discover_DIU/location8.jpg"
  },
  {
    "name": "DIU Mini Lake",
    "url": "https://maps.app.goo.gl/wfkKihEbfmWu5QaJ7",
    "image": "assets/discover_DIU/location9.jpg"
  },
  {
    "name": "DIU Lake Side",
    "url": "https://maps.app.goo.gl/5Zm7d9oLJ1xARZ5D6",
    "image": "assets/discover_DIU/location10.jpg"
  },
  {
    "name": "DIU Bus Stand",
    "url": "https://maps.app.goo.gl/ZMyoxRBb4Um8ocBbA",
    "image": "assets/discover_DIU/location11.jpg"
  },
  {
    "name": "DIU Parking Space",
    "url": "https://maps.app.goo.gl/AS53nC9yRNeh3Ehz6",
    "image": "assets/discover_DIU/location12.jpg"
  }
];

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  // Open the map URL
  void _openWebpage(String url) async {
    if (await canLaunch(url)) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      debugPrint('Could not open URL');
    }
  }

  // Show popup for a location
  void _showLocationPopup(BuildContext context, String title, String url, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                imagePath,
                height: 250,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _openWebpage(url);
                    },
                    icon: const Icon(Icons.map),
                    label: const Text('View on Map'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    label: const Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Daffodil Smart City'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top image
            Image.asset(
              'assets/images/3.jpg', // Replace with your top image path
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200, // Adjust the height as needed
            ),
            const SizedBox(height: 16), // Add some spacing

            // Scrollable ListView
            ListView.builder(
              shrinkWrap: true, // Important to make ListView fit inside Column
              physics: const NeverScrollableScrollPhysics(), // Prevent inner scrolling
              itemCount: locationData.length,
              itemBuilder: (context, index) {
                final location = locationData[index];
                return _buildClickableContainer(
                  context,
                  location['name']!,
                  location['url']!,
                  location['image']!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClickableContainer(BuildContext context, String title, String url, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () => _showLocationPopup(context, title, url, imagePath),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blueAccent.shade400,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
