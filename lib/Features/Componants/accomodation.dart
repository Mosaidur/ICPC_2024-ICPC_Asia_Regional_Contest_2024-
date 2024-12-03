import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:excel/excel.dart';
import 'package:url_launcher/url_launcher.dart';

class AccommodationPage extends StatefulWidget {
  const AccommodationPage({super.key});

  @override
  State<AccommodationPage> createState() => _AccommodationPageState();
}

class _AccommodationPageState extends State<AccommodationPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> _pages = [
    const AccommodationTab(
      title: "Accommodation for Male",
      icon: Icons.boy,
      fileName: 'assets/Accommodation Seat Plan Male.xlsx',
    ),
    const AccommodationTab(
      title: "Accommodation for Female",
      icon: Icons.girl,
      fileName: 'assets/Accommodation Seat Plan Female.xlsx',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accommodation"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.boy),
              text: "Male",
            ),
            Tab(
              icon: Icon(Icons.girl),
              text: "Female",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class AccommodationTab extends StatefulWidget {
  final String title;
  final IconData icon;
  final String fileName;

  const AccommodationTab({super.key, required this.title, required this.icon, required this.fileName});

  @override
  State<AccommodationTab> createState() => _AccommodationTabState();
}

class _AccommodationTabState extends State<AccommodationTab> {
  List<Map<String, String>> data = [];
  List<Map<String, String>> filteredData = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    loadExcelData(widget.fileName);
  }

  Future<void> loadExcelData(String fileName) async {
    ByteData excelData = await rootBundle.load(fileName);
    var bytes = excelData.buffer.asUint8List();
    var excel = Excel.decodeBytes(bytes);

    List<Map<String, String>> tempData = [];
    var table = excel.tables[excel.tables.keys.first]!;

    for (int rowIndex = 1; rowIndex < table.maxRows; rowIndex++) {
      tempData.add({
        "Team Name": table.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex)).value?.toString() ?? "",
        "Name": table.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex)).value?.toString() ?? "",
        "Assigned Room No.": table.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex)).value?.toString() ?? "",
        "University": table.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex)).value?.toString() ?? "",
      });
    }

    setState(() {
      data = tempData;
      filteredData = tempData;
    });
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
      filteredData = data.where((entry) {
        return entry.values.any((value) => value.toLowerCase().contains(query.toLowerCase()));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: updateSearch,
            decoration: InputDecoration(
              labelText: "Search",
              hintText: "Search by Team Name, Name, Room No., or University",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: data.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              final entry = filteredData[index];
              return Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Team Name: ${entry['Team Name']!}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text("Name: ${entry['Name']!}"),
                    const SizedBox(height: 4),
                    Text("University: ${entry['University']!}"),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("More Details"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Assigned Room No",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      const SizedBox(height: 6),
                                      Text("${entry['Assigned Room No.']!}"),
                                      const SizedBox(height: 12),
                                      Text("Team Name: ${entry['Team Name']!}"),
                                      const SizedBox(height: 12),
                                      Text("Name: ${entry['Name']!}"),
                                      const SizedBox(height: 12),
                                      Text("University: ${entry['University']!}"),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Close"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text("More Details"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Volunteers Info"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _volunteerInfoRow(context, "Arup Biswas", "01882663173"),
                                      const SizedBox(height: 4),
                                      _volunteerInfoRow(context, "Sadman Hafij", "01303409319"),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Close"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text("Volunteers Info"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
Widget _volunteerInfoRow(BuildContext context, String name, String phoneNumber) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            InkWell(
              onTap: () {
                Clipboard.setData(ClipboardData(text: phoneNumber));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Copied $phoneNumber to clipboard")),
                );
              },
              child: Text(
                phoneNumber,
                style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
      IconButton(
        icon: const Icon(Icons.call, color: Colors.green),
        onPressed: () => launchUrl(Uri.parse("tel:$phoneNumber")),
      ),
    ],
  );
}