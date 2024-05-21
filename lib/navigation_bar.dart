import 'package:flutter/material.dart';
import 'uploadimage.dart';
import 'admin.dart';
import 'travel.dart';
import 'food.dart';
import 'wildlife.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BottomNavigationPage extends StatefulWidget {
  final Future<List<DocumentSnapshot>> dataFood;
  final Future<List<DocumentSnapshot>> dataTravel;
  final Future<List<DocumentSnapshot>> dataWildlife;
  const BottomNavigationPage({super.key, required this.dataFood, required this.dataTravel, required this.dataWildlife});
    @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int myCurrentIndex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      FoodWallpaper(data: widget.dataFood),
      TravelWallpaper(data: widget.dataTravel),
      WildlifeWallpaper(data: widget.dataWildlife),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double displaywidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          pages[myCurrentIndex],
          Align(alignment: Alignment.bottomCenter,child: 
          
          Container(
        
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          
          boxShadow: [BoxShadow(
            
            color: Colors.grey,
            blurRadius: 30,
            offset: Offset(0,20),
          )],
        ),
        child: ClipRRect(

          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            
            currentIndex: myCurrentIndex,
            selectedItemColor: Colors.pink,
            unselectedItemColor: Colors.black,
            selectedFontSize: 12,
            unselectedFontSize: 11,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.food_bank_rounded),
                label: 'Food',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.travel_explore),
                label: 'Travel',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.forest_rounded),
                label: 'Wildlife',
              ),
            ],
          ),
        ),
      ),)
        ],
      )
      ,
    );
  }
}
