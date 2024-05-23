import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/searchpage.dart';
class CustomSearchBar extends StatelessWidget {
  final Future<List<DocumentSnapshot>> data;
  const CustomSearchBar({super.key, required this.data});

  
  @override
  
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchPage(data: data))),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Search'),
            Icon(Icons.search),
          ],),
      ),
    );
  }
}