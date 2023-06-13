// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool loading = false;

  static int id = 1;
  final TextEditingController _email = TextEditingController(),
      _pass = TextEditingController();

  static bool obscure = true;

  List<QueryDocumentSnapshot<Map<String, dynamic>>>? data;

  String? validation(String? value) {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return "This  field can't be empty !!";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

    setState(() {});
  }

  Future<void> getData() async {
    data = await FirebaseFirestore.instance
        .collection("Entries")
        .get()
        .then((value) => value.docs);
    data?.map((e) => e.data()).toList();
    id = data!.isNotEmpty ? data!.length + 1 : 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: const Text("Welcome to Leaf-Mails App"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'showData');
              },
              icon: const Icon(Icons.show_chart))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 80,
            ),
            Text.rich(TextSpan(
                text: "Already an User ? ",
                style: const TextStyle(color: Colors.indigo),
                children: [
                  TextSpan(
                      text: "Login now ",
                      style: const TextStyle(color: Colors.teal),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigator.pushReplacementNamed(context, "login");
                        }),
                  const TextSpan(
                    text: "to "
                        "continue engaging with your circle",
                  )
                ])),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                      image: AssetImage("assets/a.jpg"), fit: BoxFit.fill)),
              height: 230,
              width: double.infinity,
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
              validator: validation,
              obscureText: obscure,
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_email.text.isNotEmpty && _pass.text.isNotEmpty) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: _email.text, password: _pass.text);
                      Fluttertoast.showToast(msg: "Signed up successfully");
                      var refrence = FirebaseFirestore.instance
                          .collection("Entries")
                          .doc("$id");
                      id++;
                      refrence.set({"mail": _email.text, "pass": _pass.text});
                      setState(() {});
                      _email.clear();
                      _pass.clear();
                      Navigator.pushNamed(context, "showData");
                    } catch (e) {
                      Fluttertoast.showToast(msg: "Signed up unsuccessfull. ");
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString().split("]")[1])));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please fill both of the "
                            "fields to sign up !!")));
                  }
                },
                child: const Text("Sign Up")),
          ]),
        ),
      ),
    );
  }
}
