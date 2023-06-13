// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowEntries extends StatefulWidget {
  const ShowEntries({Key? key}) : super(key: key);

  @override
  State<ShowEntries> createState() => _ShowEntriesState();
}

class _ShowEntriesState extends State<ShowEntries> {
  List ids = [];
  TextEditingController mail = TextEditingController(),
      pass = TextEditingController();

  List<QueryDocumentSnapshot<Map<String, dynamic>>>? data;

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
    for (var element in data!) {
      ids.add(element.id);
    }

    data?.map((e) => e.data()).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ShowEntries"),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
      ),
      body: Stack(alignment: Alignment.bottomCenter,
          children: [
            Center(child: buildListView()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: "11",
                    tooltip: "Add Entry",
                    child: const Icon(Icons.add),
                    onPressed: () {
                      TextEditingController id = TextEditingController();
                      showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(
                                title: const Text("Enter New Credentials"),
                                content: Form(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: id,
                                        decoration:
                                        const InputDecoration(
                                            labelText: "Id : "),
                                        textInputAction: TextInputAction.next,
                                        autofocus: true,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        controller: mail,
                                        decoration: const InputDecoration(
                                            labelText: "Email : "),
                                        textInputAction: TextInputAction.next,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        controller: pass,
                                        decoration: const InputDecoration(
                                            labelText: "Password : "),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            if (int.tryParse(id.text) != null) {
                                              DocumentReference updater =
                                              FirebaseFirestore.instance
                                                  .collection("Entries")
                                                  .doc(id.text);
                                              updater.set({
                                                "mail": mail.text,
                                                "pass": pass.text
                                              });
                                              getData();
                                              id.clear();
                                              mail.clear();
                                              pass.clear();
                                              Navigator.pop(context);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Id must be a number !!")));
                                            }
                                          },
                                          child: const Text("ADD"))
                                    ],
                                  ),
                                ),
                              ));
                    },
                  ),
                  FloatingActionButton(
                    heroTag: "12",
                    tooltip: "Edit Entry",
                    child: const Icon(Icons.edit),
                    onPressed: () {
                      TextEditingController id = TextEditingController();

                      showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(
                                title: const Text("Enter New Credentials"),
                                content: Form(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: id,
                                        decoration:
                                        const InputDecoration(
                                            labelText: "Id : "),
                                        textInputAction: TextInputAction.next,
                                        autofocus: true,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        controller: mail,
                                        decoration: const InputDecoration(
                                            labelText: "Email : "),
                                        textInputAction: TextInputAction.next,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        controller: pass,
                                        decoration: const InputDecoration(
                                            labelText: "Password : "),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            if (int.tryParse(id.text) != null) {
                                              if (ids.contains(id.text)) {
                                                DocumentReference updater =
                                                FirebaseFirestore.instance
                                                    .collection("Entries")
                                                    .doc(id.text);
                                                updater.update({
                                                  "mail": mail.text,
                                                  "pass": pass.text
                                                });

                                                getData();
                                                id.clear();
                                                mail.clear();
                                                pass.clear();

                                                Navigator.pop(context);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            "Id not found, "
                                                                "Please enter appropriate Id")));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Id must be a number !!")));
                                            }
                                          },
                                          child: const Text("EDIT"))
                                    ],
                                  ),
                                ),
                              ));
                    },
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  Widget buildListView() {
    if (data != null) {
      return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          String email = data![index]["mail"];
          String password = data![index]["pass"];

          DocumentReference updateDelete = FirebaseFirestore.instance
              .collection("Entries")
              .doc("${ids[index]}");
          return ListTile(
            trailing: ButtonBar(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      mail.text = email;
                      pass.text = password;

                      showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(
                                title: const Text("Enter New Credentials"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: mail,
                                      decoration: const InputDecoration(
                                          labelText: "Email : "),
                                      textInputAction: TextInputAction.next,
                                      autofocus: true,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      controller: pass,
                                      decoration: const InputDecoration(
                                          labelText: "Password : "),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          updateDelete.update({
                                            "mail": mail.text,
                                            "pass": pass.text
                                          });
                                          getData();
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Edit"))
                                  ],
                                ),
                              ));
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(
                                title: const Text(
                                    "Are you sure you want to delete this entry ?"),
                                actions: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white),
                                      onPressed: () {
                                        updateDelete.delete();
                                        getData();
                                        Navigator.pop(context);
                                      },
                                      child: const Text("DELETE",
                                          style: TextStyle(color: Colors.red))),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "CANCEL",
                                        style: TextStyle(color: Colors.green),
                                      )),
                                ],
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                              ));
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
            title: Text("Email : $email"),
            subtitle: Text("Password : $password \nId : ${ids[index]}"),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
        itemCount: data!.length,
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
