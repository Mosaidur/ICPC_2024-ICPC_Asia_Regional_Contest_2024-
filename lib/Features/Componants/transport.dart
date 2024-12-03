import 'package:flutter/material.dart';

class TransportTab extends StatelessWidget {
  const TransportTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Transport Details"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Route Details'),
              Tab(text: 'Responsible Person Details'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RouteDetailsPage(),
            ResponsiblePersonDetailsPage(),
          ],
        ),
      ),
    );
  }
}

class RouteDetailsPage extends StatelessWidget {
  const RouteDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.directions_bus, size: 100, color: Colors.blue),
          SizedBox(height: 20),
          Text(
            "Route Details Here",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class ResponsiblePersonDetailsPage extends StatelessWidget {
  const ResponsiblePersonDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.person, size: 100, color: Colors.blue),
          SizedBox(height: 20),
          Text(
            "Responsible Person Details Here",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
