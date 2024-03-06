import 'dart:convert';
import 'package:apicatfacts/bor.dart';
import 'package:apicatfacts/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class bored extends StatefulWidget {
  const bored({super.key});
  @override
  State<bored> createState() => _boredState();
}
class _boredState extends State<bored> {
  Future<Bored> data() async{
    var res =  await http.get(Uri.parse("https://www.boredapi.com/api/activity"));
    return Bored.fromJson(jsonDecode(res.body));
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
                          Text(snapshot.data!.activity.toString()),
                          Text(snapshot.data!.type.toString()),
                          Text(snapshot.data!.participants.toString()),
                          Text(snapshot.data!.price.toString()),
                          Text(snapshot.data!.link.toString()),
                          Text(snapshot.data!.key.toString()),
                          Text(snapshot.data!.accessibility.toString()),
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
