import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart'; // For viewing PDFs
import 'package:carousel_slider/carousel_slider.dart';

import '../Features/AboutPage.dart';
import '../Features/CommitteePage.dart';
import '../Features/DiscoverPage.dart';
import '../Features/GalleryPage.dart';
import '../Features/OnsiteContestPage.dart';
import '../Features/PreliminaryContestPage.dart';
import '../Features/SeatPlanPage.dart';
import '../Features/VenuePage.dart';
import '../Features/Contest_schedule.dart';
import '../Features/Transport_accomodation.dart';
import 'Component/CountdownClock.dart';
import 'Component/PDFViewerPage.dart'; // For the image slider
import '../Features/Componants/accomodation.dart';
import '../Features/Componants/transport.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final targetDate = DateTime(2024, 12, 7, 0, 0, 0);


    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(
                'assets/logo/1.1 Logo Transparent.png',
                height: 40, // You can adjust the size
              ),
            ),
            Image.asset(
              'assets/images/icpclogo.png',
              height: 40, // You can adjust the size
            ),
          ],
        ),
      ),

      endDrawer: Drawer( // Changed from 'drawer' to 'endDrawer'
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/logo/1.1 Logo Transparent.png',
                          height: 40, // You can adjust the size
                        ),
                      ),
                      Image.asset(
                        'assets/images/icpclogo.png',
                        height: 40, // You can adjust the size
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'ICPC Asia Dhaka Regional',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);  // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),  // Navigate to the HomePage
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Preliminary Contest'),
              onTap: () {
                Navigator.pop(context);  // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PreliminaryContestPage()),  // Navigate to PreliminaryContestPage
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text('Onsite Contest'),
              onTap: () {
                Navigator.pop(context);  // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OnsiteContestPage()),  // Navigate to OnsiteContestPage
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);  // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GalleryPage()),  // Navigate to GalleryPage
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);  // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),  // Navigate to AboutPage
                );
              },
            ),

          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1st Container: Image Slider
            Container(
              height: 200,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: [
                  "assets/images/1.jpg",
                  "assets/images/2.jpg",
                  "assets/images/3.jpg",
                  "assets/images/4.jpg",
                  "assets/images/5.jpg",
                  // "assets/images/1.jpg"
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.asset(i, fit: BoxFit.fill);
                    },
                  );
                }).toList(),

              ),
            ),

            // 2nd Container: Features
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'ICPC ASIA DHAKA REGIONAL ONSITE CONTEST 2024',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        // color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CountdownClock(targetTime: targetDate), // Countdown widget
                  ],
                ),
              ),
            ),

            // 3rd Container: Features
            Container(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildFeatureItem(context, 'Onsite Contest', Icons.location_city, OnsiteContestPage()),
                  _buildFeatureItem(context, 'Contest Schedule', Icons.schedule, ContestSchedule()),
                  _buildFeatureItem(context, 'Seat Plan', Icons.event_seat, SeatPlanPage()),
                  _buildFeatureItem(context, 'Transport', Icons.directions_bus, TransportTab()),
                  _buildFeatureItem(context, 'Accommodation', Icons.hotel, AccommodationPage()),
                  _buildFeatureItem(context, 'Venue Location', Icons.location_on, VenuePage()),
                  _buildFeatureItem(context, 'Discover DIU', Icons.school, DiscoverPage()),
                  _buildFeatureItem(context, 'Committee', Icons.people, CommitteePage()),

                ],
              ),
            ),

            // 3rd Container: Notice Board
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Notice Board',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder<List<String>>(
                    future: fetchNotices(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No notices available.');
                      } else {
                        return Column(
                          children: snapshot.data!
                              .map((pdfUrl) => ListTile(
                            leading: const Icon(Icons.picture_as_pdf),
                            title: Text(pdfUrl.split('/').last),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PDFViewerPage(pdfUrl: pdfUrl),
                              ),
                            ),
                          ))
                              .toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String title, IconData icon, Widget page) {
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
            Icon(icon, size: 50, color: Colors.blue),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center,style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
          ],
        ),
      ),
    );
  }
}

// Dummy Future for fetching notices
Future<List<String>> fetchNotices() async {
  // Replace with your API call
  await Future.delayed(const Duration(seconds: 2));
  return ['http://www.afbl.com/notice1.pdf', 'http://www.afbl.com/notice2.pdf'];
}