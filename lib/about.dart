import 'package:flutter/material.dart';
class aboutUs extends StatelessWidget {
  const aboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon:Icon(Icons.arrow_back_ios_new,color: Colors.white,),onPressed: ()=>Navigator.of(context).pop(context),),
      ),
      body: Center(child: const Column(children: [
        SizedBox(height: 30,),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('This app was created as a side project by Sreehari',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20),),
        ),
        Text('There is nothing much to see in here!',style: TextStyle(color: Colors.white),)
      ],),),
    );
  }
}