import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:excel/excel.dart';

class SeatPlanPage extends StatefulWidget {
  @override
  _SeatPlanPageState createState() => _SeatPlanPageState();
}

class _SeatPlanPageState extends State<SeatPlanPage> {
  List<Map<String, String>> data = [];
  List<Map<String, String>> filteredData = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    loadExcelData("assets/ICPC 2024 Seat Plan .xlsx");
  }

  Future<void> loadExcelData(String fileName) async {
    ByteData excelData = await rootBundle.load(fileName);
    var bytes = excelData.buffer.asUint8List();
    var excel = Excel.decodeBytes(bytes);

    List<Map<String, String>> tempData = [];
    var table = excel.tables[excel.tables.keys.first]!;

    // Loop through the Excel rows and collect data
    for (int rowIndex = 1; rowIndex < table.maxRows; rowIndex++) {
      tempData.add({
        "Team ID": table.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex)).value?.toString() ?? "",
        "Team Name": table.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex)).value?.toString() ?? "",
        "Rank": table.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex)).value?.toString() ?? "",
        "Institution Name": table.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: rowIndex)).value?.toString() ?? "",
        "Zone": table.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: rowIndex)).value?.toString() ?? "",
        "PC_init": table.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: rowIndex)).value?.toString() ?? "",
        "PC / Seat number": table.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: rowIndex)).value?.toString() ?? "",
        "Category": table.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: rowIndex)).value?.toString() ?? "",
        "SL2": table.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: rowIndex)).value?.toString() ?? "",
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Plan'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: updateSearch,
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search by Team ID, Team Name, Rank, Institution, etc.",
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
                      Text("Preliminary Rank: ${entry['Rank']!}"),
                      const SizedBox(height: 4),
                      Text("Institution: ${entry['Institution Name']!}"),
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
                                          "Team ID: ${entry['Team ID']!}",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                        const SizedBox(height: 6),
                                        Text("Preliminary Rank: ${entry['Rank']!}"),
                                        const SizedBox(height: 12),
                                        Text("Institution: ${entry['Institution Name']!}"),
                                        const SizedBox(height: 12),
                                        Text("Zone: ${entry['Zone']!}"),
                                        const SizedBox(height: 12),
                                        Text("PC Number: ${entry['PC / Seat number']!}"),
                                        const SizedBox(height: 12),
                                        Text("Category: ${entry['Category']!}"),
                                        const SizedBox(height: 12),
                                        // Text("SL2: ${entry['SL2']!}"),
                                        //                                         // const SizedBox(height: 8),
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
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
