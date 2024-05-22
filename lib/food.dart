import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/largeview.dart';
import 'customdrawer.dart';
import 'cardview.dart';
class FoodWallpaper extends StatefulWidget {
  final Future<List<DocumentSnapshot>> data;
  const FoodWallpaper({Key? key, required this.data}):super(key: key);

  @override
  State<FoodWallpaper> createState() => _FoodWallpaperState();
}

class _FoodWallpaperState extends State<FoodWallpaper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const customDrawer(),
      appBar: AppBar(
        
        title: const Text('WallWonders',style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
        centerTitle: true,
        ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: widget.data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<DocumentSnapshot>? list = snapshot.data;
            return ListView.builder(
              itemCount: list?.length ?? 0,
              itemBuilder: (context, index) {
                DocumentSnapshot document = list![index];
               return GestureDetector(

                onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>LargeView(imageURL: document['imageURL'], title: document['title'])));},
                child: CardView(imageURL: document['imageURL'], title: document['title']));
              },
            );
          }
        },
      ),
      
    );
  }
}
