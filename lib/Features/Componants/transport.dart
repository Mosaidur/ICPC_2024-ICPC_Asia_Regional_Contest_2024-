import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:marquee/marquee.dart';


class RouteDetailsPage extends StatefulWidget {
  const RouteDetailsPage({super.key});

  @override
  _RouteDetailsPageState createState() => _RouteDetailsPageState();
}

class _RouteDetailsPageState extends State<RouteDetailsPage> {
  // List of routes with the required data
  final List<Map<String, dynamic>> routeDetails = [
    {
      "SL No": "Route-01",
      "Bus No": "Bus-1",
      "Date": "06.12.24 Friday & 07.12.24 Saturday",
      "Route Name": "Dhanmondi to DSC",
      "Route": "https://maps.app.goo.gl/USxMHFw5GDvSrBAMA",
      "Start Time (Pickup Place)": "7:00 am (Dhanmondi)",
      "Return Time": "6:00 pm",
      "Volunteer Name": "MD. SHAHRIAR HASAN",
      "Contact Number": "01611241306"
    },
    {
      "SL No": "Route-02",
      "Bus No": "Bus-2",
      "Date": "06.12.24 Friday & 07.12.24 Saturday",
      "Route Name": "Mirpur 10, Via Sony to DSC",
      "Route": "https://maps.app.goo.gl/5L1yaQbcyr7dQgk46",
      "Start Time (Pickup Place)": "7:00 am (Mirpur 10)",
      "Return Time": "6:00 pm",
      "Volunteer Name": "Md. Khalidur Rahman",
      "Contact Number": "01736720790"
    },
    {
      "SL No": "Route-03",
      "Bus No": "Bus-3",
      "Date": "06.12.24 Friday & 07.12.24 Saturday",
      "Route Name": "ECB, via Mirpur 11, Via Sony to DSC",
      "Route": "https://maps.app.goo.gl/ztyXSDBGUwEbUzqV8",
      "Start Time (Pickup Place)": "7:00 am (ECB)",
      "Return Time": "6:00 pm",
      "Volunteer Name": "Rayhan Mostafiz Rhydom",
      "Contact Number": "01794307204"
    },
    {
      "SL No": "Route-04",
      "Bus No": "Bus-4",
      "Date": "06.12.24 Friday & 07.12.24 Saturday",
      "Route Name": "Tangi, Via Rajlakkhi to DSC",
      "Route": "https://maps.app.goo.gl/fmXJj3FpWHBhhDAL8",
      "Start Time (Pickup Place)": "7:00 am (Tangi)",
      "Return Time": "6:00 pm",
      "Volunteer Name": "Lutfar Rahman Ratul",
      "Contact Number": "01304816023"
    },
    {
      "SL No": "Route-05",
      "Bus No": "Bus-5",
      "Date": "06.12.24 Friday & 07.12.24 Saturday",
      "Route Name": "Savar via C&B to DSC",
      "Route": "https://maps.app.goo.gl/4Bq8dqykrxf2xcEa6",
      "Start Time (Pickup Place)": "7:00 am (Savar)",
      "Return Time": "6:00 pm",
      "Volunteer Name": "MD. Md Sirajul Islam Nur",
      "Contact Number": "01766098803"
    },
    {
      "SL No": "Route-06",
      "Bus No": "Bus-6",
      "Date": "06.12.24 Friday & 07.12.24 Saturday",
      "Route Name": "Mugda via Rampura via Badda via Airport via Rajlakkhi to DSC",
      "Route": "https://maps.app.goo.gl/eCxAqt71ER1Tx6nY7",
      "Start Time (Pickup Place)": "6:20 am (Mugda)",
      "Return Time": "6:00 pm",
      "Volunteer Name": "MD. AMINUR RAHMAN JOY",
      "Contact Number": "01708326290"
    },
    {
      "SL No": "Route-07",
      "Bus No": "Shuttle Bus",
      "Date": "06.12.24 Friday & 07.12.24 Saturday",
      "Route Name": "Shuttle bus Service from Uttara Center metro station",
      "Route": "https://maps.app.goo.gl/uwnkMHP2CtskU65C8",
      "Start Time (Pickup Place)": "7:00 am (Uttara Center)",
      "Return Time": "6:00 pm",
      "Volunteer Name": "Ashik, Sawkot Hossen",
      "Contact Number": "01756584060, 01752085129"
    }
  ];
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard!')),
    );
  }

  Future<void> _callContact(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  void _showDetails(BuildContext context, Map<String, dynamic> route) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Volunteer Details'),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Volunteer Name: ${route['Volunteer Name']}'),
                const SizedBox(height: 5),
                Text('Contact Number: ${route['Contact Number']}'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.call, color: Colors.green),
                      onPressed: () => _callContact(route['Contact Number']),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.blue),
                      onPressed: () => _copyToClipboard(route['Volunteer Name']),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _launchURL(route['Route']), // Open map link
                  child: Text(
                    'View Map',
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Details'),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            color: Colors.red,
            child: Marquee(
              text:
              "This bus schedule is exclusively for the 'ICPC Asia Dhaka Regional Onsite Contest 2024,' scheduled for December 6th and 7th, 2024.",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              scrollAxis: Axis.horizontal,
              blankSpace: 20.0,
              velocity: 100.0,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: routeDetails.length,
              itemBuilder: (context, index) {
                final route = routeDetails[index];
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SL No: ${route['SL No']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text('Bus No: ${route['Bus No']}'),
                      Text('Route Name: ${route['Route Name']}'),
                      Text('Start Time: ${route['Start Time (Pickup Place)']}'),
                      Text('Return Time: ${route['Return Time']}'),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Volunteer: ${route['Volunteer Name']}',
                            style: const TextStyle(color: Colors.blue),
                          ),
                          Text(
                            'Contact: ${route['Contact Number']}',
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => _showDetails(context, route),
                              child: const Text('More Details'),
                            ),
                            const SizedBox(width: 10), // Adds spacing between buttons
                            ElevatedButton(
                              onPressed: () => _launchURL(route['Route']),
                              child: const Text('View Route'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),

        ],
      ),
    );
  }
}
