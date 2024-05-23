import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/components/cardview.dart';
import 'package:project/largeview.dart';
class SearchPage extends StatefulWidget {
  final Future<List<DocumentSnapshot>> data;

  SearchPage({Key? key, required this.data}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  int idx = -1;
  String title = '';
  String imageURL = '';
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchBar(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9, minHeight: 50),
              controller: _searchController,
              hintText: 'Search',
              leading: Icon(Icons.search),
              onChanged: (value) {
                setState(() {
                  idx = -1;
                });
              },
              onSubmitted: (value) async{
                List<DocumentSnapshot> snapshotList = await widget.data;
                int length = snapshotList.length;
                for(int i=0;i<length;i++) {
                  if(snapshotList[i]['title'].toString().toLowerCase()==value) {
                    setState(() {
                      idx = i;
                      imageURL = snapshotList[i]['imageURL'];
                      title = snapshotList[i]['title'];
                    });
                  }
                  
                }
              },
            ),
            idx!=-1?GestureDetector(
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LargeView(imageURL: imageURL, title: title))),
              child: CardView(imageURL: imageURL, title: title)):const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
  
}
