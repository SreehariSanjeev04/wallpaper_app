import 'package:flutter/material.dart';
import 'package:project/loginnavigation.dart';
import 'about.dart';
import 'premium.dart';
class customDrawer extends StatelessWidget {
  const customDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.black,
        child: Column(children: [
          Image.asset('assets/images/w_logo.jpg'),
          GestureDetector(
            onTap:()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AuthPage())),
            child: const ListTile(
              leading: Icon(Icons.person_2_rounded,color: Colors.white,),
              title: Text('L O G I N',style: TextStyle(color: Colors.white, fontSize: 15),),
            
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const aboutUs())),
            child: const ListTile(
              leading: Icon(Icons.question_mark_rounded,color: Colors.white,),
              title: Text('A B O U T  U S',style: TextStyle(color: Colors.white, fontSize: 15),),
            
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>getPremium())),
            child: const ListTile(
              leading: Icon(Icons.money,color: Colors.white,),
              title: Text('P R E M I U M',style: TextStyle(color: Colors.white, fontSize: 15),),
            
            ),
          )
        ],),
      );}}