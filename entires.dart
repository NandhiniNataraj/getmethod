import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'entiresmodel.dart';

class Public extends StatefulWidget {
  const Public({Key? key}) : super(key: key);

  @override
  State<Public> createState() => _PublicState();
}
class _PublicState extends State<Public> {
  late Future<List<Entries>> _futureCollection;
  @override
  void initState() {
    super.initState();
    _futureCollection = _fetchData();
  }
  Future<List<Entries>> _fetchData() async {
    var result = await http.get(Uri.parse("https://api.publicapis.org/entries"));
    var data = jsonDecode(result.body)["entries"];
    return List<Entries>.from(data.map((entry) => Entries.fromJson(entry)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Entries>>(
        future: _futureCollection,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error occurred: ${snapshot.error}',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else if (snapshot.hasData) {
            List<Entries> entries = snapshot.data!;
            return SingleChildScrollView(
              child: DataTable(
                columns: <DataColumn>[
                  DataColumn(label: Text('API',style: TextStyle(color: Colors.brown),)),
                  DataColumn(label: Text('Description',style: TextStyle(color: Colors.brown),)),
                  DataColumn(label: Text('Auth',style: TextStyle(color: Colors.brown),)),
                  DataColumn(label: Text("https",style: TextStyle(color: Colors.brown),)),
                  DataColumn(label: Text("link",style: TextStyle(color: Colors.brown),)),
                ],
                 rows: entries.map((entry) {
                   return DataRow(
                       cells: [
                         DataCell(Text(entry.aPI.toString())),
                         DataCell(Text(entry.description.toString())),
                         DataCell(Text(entry.auth.toString())),
                         DataCell(Text(entry.hTTPS.toString())),
                         DataCell(Text(entry.link.toString())),
                       ]);
                 }              //   DataRow(cells: [
              ).toList()
              ),
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
