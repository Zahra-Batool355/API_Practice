import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Fixed: Properly typed and uses 'http'
  void login() async {
    try {
      var url = Uri.parse('https://reqres.in/api/login');
      var response = await http.post(
        url,
        headers: {
          'x-api-key': 'reqres-free-v1'
        },
        body: {
          "email": "eve.holt@reqres.in",
          "password": "pistol"
        },//2f709fa7678e416985866d3104e704e2    https://newsapi.org/v2/everything?q=tesla&from=2025-06-10&sortBy=publishedAt&apiKey=API_KEY
      );

      print('checking response...');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        print('Login successfully');
      } else {
        print(' Failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print(' Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogIn'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: true, // secure password input
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                login();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'LogIn',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
