import 'package:flutter/material.dart';
import '../Features/Componants/accomodation.dart';
import '../Features/Componants/transport.dart';


class TransportAndAccommodation extends StatelessWidget {
  const TransportAndAccommodation({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Transport & Accommodation"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_bus), text: "Transport"),
              Tab(icon: Icon(Icons.hotel), text: "Accommodation"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TransportTab(),
            AccommodationPage(),
          ],
        ),
      ),
    );
  }
}


