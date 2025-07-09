import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // <-- Important for API calls
import 'Models/PostModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postList = [];

  Future<List<PostModel>> getPostApi() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts")); // Fixed .get
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      postList.clear(); // Avoid duplicating data on rebuild
      for (var i in data) {
        postList.add(PostModel.fromJson(i as Map<String, dynamic>));
      }

      return postList;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Practice")),
      body:


      Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text("Title\n"+postList[index].title.toString(),style: TextStyle(fontWeight: FontWeight.bold,),),
                              subtitle: Text("Description \n"+postList[index].body.toString()),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
