import 'dart:io';

// import 'package:cr_file_saver/file_saver.dart';
// import 'package:dio/dio.dart';
// import 'package:dio/io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast;
import 'package:media_store_plus/media_store_plus.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class ShareFiles extends StatefulWidget {
  const ShareFiles({Key? key}) : super(key: key);

  @override
  State<ShareFiles> createState() => _ShareFilesState();
}

class _ShareFilesState extends State<ShareFiles> {
  bool uploading = false;
  File? pickedFile;
  String downloadUrl = "", downloadsPath = "";
  TextEditingController url = TextEditingController();
  OutlineInputBorder borders = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.pink, width: 1));
  MediaStore obj = MediaStore();

  Reference? a;

  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    obj.saveFile(
        tempFilePath: "/storage/emulated/0/Download",
        dirType: DirType.download,
        dirName: DirName.download);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("My File To Link Converter App"),
          backgroundColor: Colors.teal,
          actions: [
            IconButton(
              tooltip: "Delete All Files",
                onPressed: () async {
                  await FirebaseStorage.instance.ref("uploads").delete();
                  Fluttertoast.showToast(msg: "All files deleted from the "
                      "severe");
                },
                icon: Icon(Icons.delete))
          ]),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text(
                        "Url : ",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        padding: const EdgeInsets.all(5),
                        child: TextFormField(
                          controller: url,
                          decoration: const InputDecoration(
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // ElevatedButton.icon(
                    //   onPressed: () async {
                    //     if (await Permission.manageExternalStorage.isGranted) {
                    //       Directory appFolder = await Directory(
                    //               "/storage/emulated/0/FlutterStorageExample")
                    //           .create();
                    //       print(appFolder.path);
                    //       downloadsPath =
                    //           "${appFolder.path}/AppFile001.${url.text.split(".").last.substring(0, 3)}";
                    //       await download();
                    //     } else {
                    //       Map<Permission, PermissionStatus> statuses = await [
                    //         Permission.manageExternalStorage,
                    //         Permission.storage,
                    //         Permission.camera,
                    //       ].request();
                    //       if (statuses[Permission.manageExternalStorage]!
                    //           .isGranted) {
                    //         Directory appFolder = await Directory(
                    //                 "/storage/emulated/0/FlutterStorageExample")
                    //             .create();
                    //         print(appFolder.path);
                    //         downloadsPath =
                    //             "${appFolder.path}/AppFile001.${url.text.split(".").last.substring(0, 3)}";
                    //         await download();
                    //       } else {
                    //         Directory appFolder =
                    //             Directory("/storage/emulated/0/Flutter_Storage_"
                    //                 "Example");
                    //         // print(appFolder.path);
                    //         // print("${await Permission.storage.isGranted}");
                    //         Fluttertoast.showToast(
                    //             msg:
                    //                 "Please grant storage permission to download the file");
                    //         openAppSettings();
                    //       }
                    //     }
                    //   },
                    //   icon: const Icon(Icons.download),
                    //   label: const Text("Download"),
                    // ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (url.text.isNotEmpty) {
                          Share.share(url.text);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please select the file "
                                  "to get the download url");
                        }
                      },
                      icon: const Icon(Icons.share),
                      label: const Text("Share"),
                    ),
                  ],
                ),
                const Divider(),
                const Center(
                  child: Text(
                    "Select the file you want to send",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const Divider(),
                TextButton(
                  onPressed: () async {
                    FilePickerResult? picked =
                        await FilePicker.platform.pickFiles();
                    if (picked != null && picked.isSinglePick) {
                      pickedFile = File(picked.files.single.path!);
                      Fluttertoast.showToast(msg: "File Picked Successfully");
                      String fileName = picked.files.single.name;
                      a = FirebaseStorage.instance
                          .ref("uploads")
                          .child("${DateTime.now().microsecondsSinceEpoch}")
                          .child(fileName);
                      setState(() {
                        uploading = true;
                      });
                      var b = await a!.putFile(pickedFile!);
                      print(b.state);
                      downloadUrl = await a!.getDownloadURL();
                      print(downloadUrl);
                      a!.updateMetadata(
                          SettableMetadata(customMetadata: {"name": "$fileName"}));
                      setState(() {
                        uploading = false;
                      });

                      // print("Filenaem ====== $fileName");
                      Fluttertoast.showToast(msg: "Link Generated Successfully");
                      setState(() {
                        url.text = downloadUrl;
                      });
                    } else {
                      Fluttertoast.showToast(msg: "Didn't Picked The File");
                    }
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Icon(
                          Icons.image_outlined,
                          color: Colors.lightBlueAccent.shade100,
                          size: 150,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text("Select the file from your device")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          uploading ? Card(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 50,),
                  Text("Uploading...")
                ],
              ),
            ),
          ) : SizedBox()
        ],
      ),
    );
  }

  // Future<void> download() async {
  //   if (Platform.isAndroid) {
  //     try {
  //       // Dio().download(downloadUrl, downloadsPath);
  //       // var dataa =
  //       //     await FirebaseStorage.instance.refFromURL(downloadUrl).getData();
  //       // var a = await http.get(Uri.parse(downloadUrl));
  //       // XFile a = XFile.fromData(dataa!);
  //       // File b = File(a.path);
  //       // File downloaded = await File(downloadsPath).create();
  //       // downloaded.writeAsBytes(a.bodyBytes);
  //       String? ddg = await CRFileSaver.saveFile(
  //           "/storage/emulated/0/FlutterStorageExample",
  //           destinationFileName: "File01");
  //       print(ddg);
  //       if (kDebugMode) {
  //         // print("file downlaoded here\n\n $downloadsPath");
  //       }
  //       Fluttertoast.showToast(
  //           msg: "$downloadsPath is the path to the "
  //               "downloaded "
  //               "file");
  //     } catch (error) {
  //       print(downloadsPath);
  //       print(downloadUrl);
  //
  //       print("\n\n\n\nThe error is : ");
  //       print(error.toString() + "\n\n\n\n");
  //       Fluttertoast.showToast(
  //           msg: "File didn't downloaded, perhaps some "
  //               "error occured");
  //     }
  //   } else {
  //     Directory? downloadsFolder = await getDownloadsDirectory();
  //     if (downloadsFolder != null) {
  //       downloadsPath =
  //           downloadsFolder.path + "${DateTime.now().microsecondsSinceEpoch}";
  //       try {
  //         Dio().download(downloadUrl, downloadsPath);
  //         DioForNative().download(downloadUrl, downloadsPath);
  //         print("file downlaoded here\n\n $downloadsPath");
  //         Fluttertoast.showToast(
  //             msg: "$downloadsPath is the path to the "
  //                 "downloaded "
  //                 "file");
  //       } catch (error) {
  //         print(error.toString());
  //         Fluttertoast.showToast(
  //             msg: "File didn't downloaded, perhaps some "
  //                 "error occured");
  //       }
  //     }
  //   }
  // }
}
