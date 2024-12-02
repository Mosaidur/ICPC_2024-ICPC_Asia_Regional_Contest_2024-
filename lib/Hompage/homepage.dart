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
import 'Component/CountdownClock.dart';
import 'Component/PDFViewerPage.dart'; // For the image slider



class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final targetDate = DateTime(2024, 12, 7, 0, 0, 0);


    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Centers the images
          children: [
            Expanded(
              child: Image.asset(
                'assets/logo/1.1 Logo Transparent.png',
                height: 40, // You can adjust the size
                // width: 40,
              ),
            ),
            Image.asset(
              'assets/images/icpclogo.png',
              height: 40, // You can adjust the size
            ),
            // Image.asset(
            //   'assets/images/DIULOGO.png',
            //   height: 40, // You can adjust the size
            // ),
            // SizedBox(width: 10), // Adds some space between the two images

          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              // Handle menu item selection
              print('Selected: $value');
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'Option 1',
                  child: Text('Option 1'),
                ),
                PopupMenuItem<String>(
                  value: 'Option 2',
                  child: Text('Option 2'),
                ),
                PopupMenuItem<String>(
                  value: 'Option 3',
                  child: Text('Option 3'),
                ),
              ];
            },
          ),
        ],
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
                  _buildFeatureItem(context, 'Venue Location', Icons.location_on, VenuePage()),
                  _buildFeatureItem(context, 'Discover DIU', Icons.school, DiscoverPage()),
                  _buildFeatureItem(context, 'Seat Plan', Icons.event_seat, SeatPlanPage()),
                  _buildFeatureItem(context, 'Committee', Icons.people, CommitteePage()),
                  _buildFeatureItem(context, 'About', Icons.info, AboutPage()),
                  _buildFeatureItem(context, 'Preliminary Contest', Icons.emoji_events, PreliminaryContestPage()),
                  _buildFeatureItem(context, 'Gallery', Icons.photo_album, GalleryPage()),
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