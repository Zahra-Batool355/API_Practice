import 'dart:convert';

import 'package:apilearning/Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUserApi() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );
    print(response.body);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        print(i["name"]);
        userList.add(UserModel.fromJson(i as Map<String, dynamic>));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Complex json")),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,

                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ReusableRow(title: "Name", value: snapshot.data![index].name.toString()),
                              ReusableRow(title: "UserName", value: snapshot.data![index].username.toString()),
                              ReusableRow(title: "Email", value: snapshot.data![index].email.toString()),
                              ReusableRow(title: "Address", value: snapshot.data! [index].address!.city.toString()),
                            ],
                          ),
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
class ReusableRow extends StatelessWidget {
  String title, value;
   ReusableRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value ),

      ],
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

