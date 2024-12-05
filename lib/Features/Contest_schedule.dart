import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';


class ContestSchedule extends StatelessWidget {
  const ContestSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Onsite Contest Schedule'),
          bottom: const TabBar(
            tabs: [

              Tab(text: 'Program Flow'),
              Tab(text: 'Program Rundown'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [

            ProgramFlowTab(),
            ProgramRundownTab(),
          ],
        ),
      ),
    );
  }
}

class ProgramRundownTab extends StatelessWidget {
  const ProgramRundownTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            color: Colors.red,
            child: Marquee(
              text: "Note: The program schedule is subject to change without prior notice.",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              scrollAxis: Axis.horizontal,
              blankSpace: 20.0,
              velocity: 100.0,
            ),
          ),

          const SizedBox(height: 10),
          const Text(
            'Inauguration Program',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
          ),
          const SizedBox(height: 10),

          _buildScheduleTable([
            ['8:00 AM', 'Contestant Enter Contest Floor'],
            ['8:30 AM', 'Guest Arrives'],
            ['9:00 AM', 'Daffodil Theme Song'],
            ['9:05 AM', 'Welcome from Prof. M. Lutfar Rahman'],
            ['9:10 AM', 'Direction from Prof. Dr. Syed Akhter Hossain'],
            ['9:13 AM', 'Welcome Video of Prof. Bill Poucher'],
            ['9:15 AM', 'Problem Set Distribution by Volunteers'],
            ['9:20 AM', 'ICPC Asia Dhaka Regional 2024 Begins'],
          ]),
          const SizedBox(height: 20),
          const Text(
            'Award Night Celebration',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
          ),
          const SizedBox(height: 10),
          _buildScheduleTable([
            ['3:15 PM', 'Guests Take Their Seats'],
            ['3:30 PM', 'ICPC Asia Dhaka Regional 2024 Highlights'],
            ['3:40 PM', 'Reciting from Holy Books'],
            ['3:45 PM', 'Welcome by Prof. Dr. S.M. Mahbub Ul Haque Majumder'],
            ['3:48 PM', 'Address by Mr. Abul Kashem Md. Shirin'],
            ['3:53 PM', 'Address by Dr. Muhammad Mehedi Hassan'],
            ['4:00 PM', 'Recognition of System Engineers - Crest Giving'],
            ['5:05 PM', 'Award-Giving Ceremony'],
          ]),
        ],
      ),
    );
  }

  Widget _buildScheduleTable(List<List<String>> schedule) {
    return Table(
      border: TableBorder.all(color: Colors.grey, width: 1),
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(7),
      },
      children: schedule
          .map(
            (row) => TableRow(
          children: row.map(
                (cell) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(cell),
            ),
          ).toList(),
        ),
      )
          .toList(),
    );
  }
}

class ProgramFlowTab extends StatelessWidget {
  const ProgramFlowTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            color: Colors.red,
            child: Marquee(
              text: "Note: The program schedule is subject to change without prior notice.",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              scrollAxis: Axis.horizontal,
              blankSpace: 20.0,
              velocity: 100.0,
            ),
          ),

          // const SizedBox(height: 20),
          // const Text(
          //   'Asia ICPC Dhaka Regional Site 2024 Program Flow',
          //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
          // ),
          const SizedBox(height: 20),
          const Text(
            'MOCK DAY - Day 1 (Friday, December 6, 2024)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          _buildFlowTable([
            ['7:30 AM', '7:45 AM', 'Shuttle Transport from different locations of Dhaka City for DIU Premises', 'Dhaka', 'ICPC Dhaka Regional Attendees'],
            ['8:30 AM', '9:00 AM', 'Arrival at DIU DSC', 'DSC, DIU', 'ICPC Dhaka Regional Attendees'],
            ['9:00 AM', '10:00 AM', 'Kit Distribution & Photo Session', 'Knowledge Tower Ground Floor and G2', 'Contestants and Coaches'],
            ['10:00 AM', '12:00 PM', 'Mock Contest', 'Shadhinota Sommelon Kendro - DSC', 'Contestants'],
            ['11:00 AM', '-', 'Light Snacks Distribution (Contest Floor)', 'Shadhinota Sommelon Kendro - DSC', 'Contestants'],
            ['11:00 AM', '-', 'Light Snacks Distribution (Student Lounge)', 'Knowledge Tower', 'Coaches'],
            ['12:00 PM', '1:00 PM', 'Shuttle Transport from DIU Premises to different locations', 'Transport Section, DIU', 'Attendees'],
          ]),
          const SizedBox(height: 30),
          const Text(
            'FINAL DAY - Day 2 (Saturday, December 7, 2024)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          _buildFlowTable([
            ['7:00 AM', '7:10 AM', 'Shuttle Transport from different locations of Dhaka City for DIU Premises', 'Dhaka', 'Attendees'],
            ['8:00 AM', '-', 'Arrival at DIU DSC', 'Transport Section, DIU', 'Attendees'],
            ['8:00 AM', '8:20 AM', 'Judges take seats', 'Judge Room, Shadhinota Sommelon Kendro', 'Judges'],
            ['8:10 AM', '8:25 AM', 'Contestants take seats', 'Shadhinota Sommelon Kendro', 'Contestants'],
            ['8:00 AM', '9:30 AM', 'Kit Distribution [available in seats]', 'Knowledge Tower Ground Floor and G2', 'Attendees'],
            ['8:45 AM', '8:50 AM', 'Guest Arrival', 'Teacher’s Lounge, Knowledge Tower', 'Guests'],
            ['8:50 AM', '9:00 AM', 'Problem Set Distribution', 'Shadhinota Sommelon Kendro', 'Contestants'],
            ['8:55 AM', '-', 'Contest Opening Announcement', 'Main Stage, Shadhinota Sommelon Kendro', 'RCD and Guests'],
            ['9:00 AM', '2:00 PM', 'Contest Starts', 'Shadhinota Sommelon Kendro', 'Contestants'],
            ['9:20 AM', '9:40 AM', 'Breakfast Distribution (Contest Floor)', 'Shadhinota Sommelon Kendro', 'Contestants'],
            ['9:30 AM', '9:50 AM', 'Breakfast Distribution (Guests and Coaches)', 'Green Garden, Food Court', 'Attendees'],
            ['9:00 AM', '2:00 PM', 'Live Contest & Rankings Showcase', 'Student Lounge, Knowledge Tower', 'Attendees'],
            ['10:30 AM', '11:30 AM', 'CP Workshop', 'International Conference Hall (ICH)', 'Attendees'],
            ['10:30 AM', '11:30 AM', 'AI Tech Talks', 'Aminul Islam Hall', 'Attendees'],
            ['11:00 AM', '1:00 PM', 'Junior Competitive Programming Contest', 'Knowledge Tower', 'JCPC Contestants'],
            ['2:00 PM', '2:00 PM', 'Contest Ends', 'Shadhinota Sommelon Kendro', 'Contestants'],
            ['2:00 PM', '3:00 PM', 'Lunch Distribution', 'Shadhinota Sommelon Kendro', 'Contestants'],
            ['3:30 PM', '5:00 PM', 'Award Night', 'Shadhinota Sommelon Kendro', 'Attendees'],
            ['5:30 PM', '5:35 PM', 'Closing Ceremony', 'Shadhinota Sommelon Kendro', 'Attendees'],
            ['5:40 PM', '6:40 PM', 'Buffet Dinner', 'Green Garden, Food Court', 'Attendees'],
            ['6:30 PM', '7:00 PM', 'Departure to Dhaka City Locations', 'Transport Section, DIU', 'Attendees'],
          ]),
        ],
      ),
    );
  }

  Widget _buildFlowTable(List<List<String>> schedule) {
    return Table(
      border: TableBorder.all(color: Colors.grey, width: 1),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(5),
        3: FlexColumnWidth(3),
        4: FlexColumnWidth(4),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.blueAccent.withOpacity(0.2)),
          children: const [
            Padding(padding: EdgeInsets.all(8.0), child: Text('Start', style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(padding: EdgeInsets.all(8.0), child: Text('End', style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(padding: EdgeInsets.all(8.0), child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(padding: EdgeInsets.all(8.0), child: Text('Location', style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(padding: EdgeInsets.all(8.0), child: Text('Attendees', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
        for (var row in schedule)
          TableRow(
            children: row.map(
                  (cell) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(cell),
              ),
            ).toList(),
          ),
      ],
    );
  }
}
