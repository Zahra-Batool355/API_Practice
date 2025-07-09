import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photos> photoList = [];

  Future<List<Photos>?>getPhotos() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    print(response.body);

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200){
      for(var i in data){
       // photoList.add(Photos.fromJson(i as Map<String,dynamic>));
        Photos photos = Photos(i["title"], i["url"], i['id']);

        photoList.add(photos);
      }
      return photoList;
    }
    else{
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("API Practice"),
      ),
      body: Column(

        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
              builder: (context, snapshot) {
                // While data is loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                // If some error occurred
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                // If data is loaded
                if (snapshot.hasData && snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                        ),
                        subtitle: Text("Title: ${snapshot.data![index].title}"),
                        title: Text("ID: ${snapshot.data![index].id}"),
                      );
                    },
                  );
                }

                // Fallback (shouldn't usually happen)
                return Center(child: Text("No data available."));
              },
            ),
          ),

        ],
      ),

    );
  }
}
class Photos{
  String title,url;
  int id;
  Photos( this.title, this.url,this.id);
}
