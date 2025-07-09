import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
    var data;
  Future<void> getUserApi() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());


    }else{

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Without Model")),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting){
                     return Text("Loading...");
              }else{
                 //return Text(data[0]["name"].toString());
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context,index){
                        return Card(
                          child: Column(
                            children: [
                              ReusableRow(title: "Name", value: data[index]["name"].toString()),
                              ReusableRow(title: "UserName", value: data[index]["username"].toString()),
                              ReusableRow(title: "address", value: data[index]["address"]['street'].toString()),
                              ReusableRow(title: "geo", value: data[index]["address"]['geo']['lat'].toString()),
                            ],
                          ),
                        );
                        
                      });

              }
              }
            ),
          ),
        ],
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value ),

        ],
      ),
    );
  }
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Text("Name",style: TextStyle(fontWeight: FontWeight.bold),),
// Text(snapshot.data![index].name.toString()),
// ],
// ),
}
