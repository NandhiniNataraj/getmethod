import 'dart:convert';

import 'package:apicatfacts/agemodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class age extends StatefulWidget {
  const age({super.key});

  @override
  State<age> createState() => _ageState();
}

class _ageState extends State<age> {
  Future<Age> data() async{
    var res =  await http.get(Uri.parse("https://api.agify.io?name=meelad"));
    return Age.fromJson(jsonDecode(res.body));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: FutureBuilder(
              builder: (ctx, snapshot) {
                if (snapshot.hasData){
                  return Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Text(snapshot.data!.age.toString()),
                          Text(snapshot.data!.name.toString()),
                          Text(snapshot.data!.count.toString()),
                        ],
                      )],
                  );
                } else if(snapshot.hasError) {
                  return Column(
                    children: [
                      Text("${snapshot.error} occurred")
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              future: data(),
            ),
          )
        ],
      ),
    );
  }
}
