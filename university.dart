import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class University {
  final String alphaTwoCode;
  final String country;
  final String name;

  University({required this.alphaTwoCode, required this.country, required this.name});

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      alphaTwoCode: json['alpha_two_code'],
      country: json['country'],
      name: json['name'],
    );
  }
}

class Uni extends StatefulWidget {
  const Uni({Key? key}) : super(key: key);

  @override
  State<Uni> createState() => _UniState();
}

class _UniState extends State<Uni> {
  late Future<List<University>> _universitiesFuture;

  @override
  void initState() {
    super.initState();
    _universitiesFuture = _fetchUniversities();
  }

  Future<List<University>> _fetchUniversities() async {
    var response = await http.get(Uri.parse("http://universities.hipolabs.com/search?country=United+States"));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body) as List;
      List<University> universities = jsonData.map((e) => University.fromJson(e)).toList();
      return universities;
    } else {
      throw Exception('Failed to load universities');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _universitiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<University>? universities = snapshot.data as List<University>?;

            return ListView.builder(
              itemCount: universities!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(universities[index].name),
                  subtitle: Text(universities[index].country),
                );
              },
            );
          }
        },
      ),
    );
  }
}
