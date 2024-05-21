import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'largeview.dart';
import 'admin.dart';
class TravelWallpaper extends StatefulWidget {
    final Future<List<DocumentSnapshot>> data;
  const TravelWallpaper({super.key, required this.data});

  @override
  State<TravelWallpaper> createState() => _TravelWallpaperState();
}

class _TravelWallpaperState extends State<TravelWallpaper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Column(children: [
          Image.network('https://static.vecteezy.com/system/resources/thumbnails/004/891/075/small/the-initials-w-logo-is-simple-and-modern8868-free-vector.jpg'),
          GestureDetector(
            onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdminLogin())),
            child: const ListTile(
              leading: Icon(Icons.person_2_rounded,color: Colors.white,),
              title: Text('L O G I N',style: TextStyle(color: Colors.white, fontSize: 15),),
            
            ),
          ),
          const ListTile(
            leading: Icon(Icons.question_mark_rounded,color: Colors.white,),
            title: Text('A B O U T  U S',style: TextStyle(color: Colors.white, fontSize: 15),),

          ),
          const ListTile(
            leading: Icon(Icons.money,color: Colors.white,),
            title: Text('P R E M I U M',style: TextStyle(color: Colors.white, fontSize: 15),),

          )
        ],),
      ),
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
            // Data has been successfully fetched
            List<DocumentSnapshot>? list = snapshot.data;
            // You can now use the list of documents to build your UI
            return ListView.builder(
              itemCount: list?.length ?? 0,
              itemBuilder: (context, index) {
                DocumentSnapshot document = list![index];
                // Build UI based on document data
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

class CardView extends StatefulWidget {
  final String imageURL;
  final String title;
  const CardView({Key? key, required this.imageURL, required this.title}) : super(key:key);

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.maxFinite,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(
            widget.imageURL,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}