import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';


class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('wallpaper_info');
  String? dropDownSelection = '';
  String downloadURL = '';
  final items = ['Select', 'Wildlife', 'Food', 'Travel'];
  String? value;
  List<String> displayImages = [];
  final _titleController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  @override
  void initState() {
    super.initState();
    value = items.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          tooltip: 'Back',
        ),
        title: const Text(
          'Add Wallpaper',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () async {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pop(context);
            },
            icon: const Icon(Icons.exit_to_app_rounded),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: TextFormField(
                      key: key,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      controller: _titleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  DropdownButton<String>(
                    value: value,
                    items: items.map(buildMenuItem).toList(),
                    onChanged: (value) => setState(() {
                      this.value = value;
                      dropDownSelection = value;
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Make sure that the image has been uploaded to the cloud before tapping on UPLOAD through notification'),
                    behavior: SnackBarBehavior.floating,backgroundColor: Colors.deepOrange,duration: Duration(seconds: 7),)

                  );
                  if(displayImages.isNotEmpty) displayImages.clear();
                  pickImageAndUpload();
                  
                },
                icon: const Icon(Icons.image_search),
              ),
              displayImages.isNotEmpty
                  ? DisplayImage(imageURL: displayImages.last)
                  : const SizedBox.shrink(),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  
                  if (downloadURL.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select an image'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  if (_titleController.text.isEmpty || dropDownSelection=='Select' || dropDownSelection!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fill the details'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  String itemName = _titleController.text;
                  if (dropDownSelection == null) return;
                  Map<String, String> dataToSend = {
                    'title': itemName,
                    'imageURL': downloadURL,
                    'category': dropDownSelection!,
                  };
                  _reference.add(dataToSend);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Wallpaper has been added'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,));
                },
                child: const Text('Upload'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImageAndUpload() async {
    ImagePicker imgPicker = ImagePicker();
    XFile? file =
        await imgPicker.pickImage(source: ImageSource.gallery);
    setState(() {
      displayImages.add(file!.path);
    });
    String uniquePathName =
        DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages =
        referenceRoot.child('images');
    Reference referenceFileImages =
        referenceDirImages.child(uniquePathName);
    try {
      await referenceFileImages.putFile(File(file!.path));
      String url = await referenceFileImages.getDownloadURL();
      setState(() {
        downloadURL=url;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image has been uploaded, kindly fill other details!'),
      behavior: SnackBarBehavior.floating, backgroundColor: Colors.green));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      );
}

class DisplayImage extends StatefulWidget {
  final String imageURL;

  const DisplayImage({Key? key, required this.imageURL}) : super(key: key);

  @override
  _DisplayImageState createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          File(widget.imageURL),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
