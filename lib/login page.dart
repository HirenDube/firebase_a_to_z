// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _email = TextEditingController(),
      _pass = TextEditingController();
  static bool obscure = true;

  String? validation(String? value) {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return "This  field can't be empty !!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "showData");
              },
              icon: const Icon(Icons.data_array))
        ],
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: const Text("Welcome to Leaf-Mails App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 80,
            ),
            Text.rich(TextSpan(
                text: "New User ? ",
                style: const TextStyle(color: Colors.indigo),
                children: [
                  TextSpan(
                      text: "Register now ",
                      style: const TextStyle(color: Colors.teal),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacementNamed(context, "register");
                        }),
                  const TextSpan(
                    text: "to "
                        "start engaging with your circle",
                  )
                ])),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 230,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                      image: AssetImage("assets/a.jpg"), fit: BoxFit.fill)),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(labelText: "E-mail : "),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: validation,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _pass,
              decoration: InputDecoration(
                  labelText: "Password : ",
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      icon: Icon(obscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined))),
              keyboardType: TextInputType.visiblePassword,
              obscureText: obscure,
              validator: validation,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    var user = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                        email: _email.text, password: _pass.text);
                    Fluttertoast.showToast(msg: "Signed in successfully");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Your UID is ${user.user?.uid}")));
                    // FirebaseAuth.instance.currentUser?.delete();
                    _pass.clear();
                    _email.clear();
                    Navigator.pushNamed(context, "showData");
                  } catch (e) {
                    Fluttertoast.showToast(msg: "Signed up unsuccessfully. ");
                  }
                },
                child: const Text("Sign In"))
          ]),
        ),
      ),
    );
  }
}
