import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:excel/excel.dart';

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
              : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("Team Name")),
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Assigned Room No.")),
                  DataColumn(label: Text("University")),
                ],
                rows: filteredData.map((entry) {
                  return DataRow(
                    cells: [
                      DataCell(Text(entry["Team Name"]!)),
                      DataCell(Text(entry["Name"]!)),
                      DataCell(Text(entry["Assigned Room No."]!)),
                      DataCell(Text(entry["University"]!)),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
