import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Fixed: Properly typed and uses 'http'
  void login() async {
    try {
      var url = Uri.parse('https://reqres.in/api/register');
      var response = await http.post(
        url,
        headers: {
          'x-api-key': 'reqres-free-v1'
        },
        body: {
          "email": "eve.holt@reqres.in",
          "password": "pistol"
        },
      );

      print('checking response...');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        print('✅ Account created successfully');
      } else {
        print('❌ Failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('⚠️ Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
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
                    'SignUp',
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


// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
//
// class SignUpScr extends StatefulWidget {
//   const SignUpScr({super.key});
//
//   @override
//   State<SignUpScr> createState() => _SignUpScrState();
// }
//
// class _SignUpScrState extends State<SignUpScr> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   void login(String email,password) async{
//     try{
//
//       Response response = await post(Uri.parse("https://reqres.in/api/register"),
//           headers: {
//             'Content-Type': 'application/x-www-form-urlencoded',
//             'Authorization': 'reqres-free-v1',  // Add this line
//           },
//       body: {
//         'email' : email,
//         'password' : password,
//       });
//       if(response.statusCode == 200){
//         print("Account Created Successfully");
//         print(response.body);
//       }else{
//         print("Failed");
//         print(response.body);
//       }
//   }catch(e){
//       print(e.toString());
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title:Text("SignUp") ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller: emailController,
//               decoration: InputDecoration(
//                 hintText: "Email",
//               ),
//             ),SizedBox(
//               height: 20,
//             ),
//             TextFormField(
//               controller: passwordController,
//               decoration: InputDecoration(
//                 hintText: "Password",
//               ),
//             ),
//             SizedBox(height: 40,),
//             GestureDetector(
//               onTap: (){
//                 login(emailController.text.toString(),passwordController.text.toString());
//               },
//               child: Container(
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                   child: Text("SignUp"),
//                 ),
//               ),
//             )
//
//           ],
//         ),
//       ),
//     );
//   }
// }
