import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/wallpaper.dart';
import 'dart:io';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('wallpaper_info');
  String? dropDownSelection = '';
  String downloadURL = '';
  final items = ['Select', 'Wildlife', 'Food', 'Travel'];
  String? value;
  final _titleController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();

  @override
  void initState() {
    super.initState();
    value = items.first; // Initialize value to the first item in the list
  }

  @override
  Widget build(BuildContext context) {
    String displayURL =
        'https://t3.ftcdn.net/jpg/02/43/51/48/360_F_243514868_XDIMJHNNJYKLRST05XnnTj0MBpC4hdT5.jpg';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop(context); 
        },icon: Icon(Icons.arrow_back_ios_new),tooltip: 'Back',),
        title: const Text(
          'Add Wallpaper',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        
        elevation: 0,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () async{
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.clear();
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
              DisplayImage(imageURL: displayURL),
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
                      print('DropDownSelection: ${dropDownSelection}');
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              IconButton(
                onPressed: () async {
                  ImagePicker imgPicker = ImagePicker();
                  XFile? file =
                      await imgPicker.pickImage(source: ImageSource.gallery);
                  String uniquePathName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirImages =
                      referenceRoot.child('images');
                  Reference referenceFileImages =
                      referenceDirImages.child(uniquePathName);
                  try {
                    await referenceFileImages.putFile(File(file!.path));
                    downloadURL =
                        await referenceFileImages.getDownloadURL();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Kindly wait for atleast 10 seconds before tapping on upload'),
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
                },
                icon: const Icon(Icons.image_search),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (downloadURL.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select an image'),
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
                },
                child: const Text('Upload'),
              ),
            ],
          ),
        ),
      ),
    );
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
        child: Image.network(
          widget.imageURL,
          key: UniqueKey(), // Add a unique key to force image reload
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
