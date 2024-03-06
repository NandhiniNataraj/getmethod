import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Publicmodal.dart';

class public extends StatefulWidget {
  const public({super.key});

  @override
  State<public> createState() => _publicState();
}

class _publicState extends State<public> {
  Future<List<Entries>> collection ()async{
    var result = await http.get(Uri.parse("https://api.publicapis.org/entries"));
    var data = jsonDecode(result.body)["entries"];
    return (data as List).map((e) => Entries.fromJson(e)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: TextStyle(fontSize: 18),
                ),
              );

              // if we got our data
            } else if (snapshot.hasData) {
              List<Entries> list = snapshot.data!;
              // Extracting data from snapshot object
              return ListView.builder(
                itemCount: list.length,
                  itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    title: Center(
                      child: Column(
                        children: [
                          Text(list[index].aPI.toString()),
                          Text(list[index].description.toString()),
                          Text(list[index].auth.toString()),
                          Text(list[index].hTTPS.toString()),
                          Text(list[index].cors.toString()),
                          Text(list[index].link.toString()),
                          Text(list[index].category.toString()),
                        ],
                      ),
                    ),
                  );
                  }
              );
            }
          }
          // Displaying LoadingSpinner to indicate waiting state
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        // Future that needs to be resolved
        // inorder to display something on the Canvas
        future: collection(),
      ),
    );
  }
}
