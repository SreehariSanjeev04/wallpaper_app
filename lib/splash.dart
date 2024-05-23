import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/components/navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<List<DocumentSnapshot>> _futureDataFood;
  late Future<List<DocumentSnapshot>> _futureDataTravel;
  late Future<List<DocumentSnapshot>> _futureDataWildlife;

  @override
  void initState() {
    super.initState();
    _futureDataFood = fetchDataFood();
    _futureDataTravel = fetchDataTravel();
    _futureDataWildlife = fetchDataWildlife();
    _futureDataWildlife.then((data) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>BottomNavigationPage(dataFood: _futureDataFood, dataTravel: _futureDataTravel, dataWildlife: _futureDataWildlife)));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data, try again later!'),behavior: SnackBarBehavior.floating,backgroundColor: Colors.red,)
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.deepPurple
        ),
        child: const Stack(
          children: [
            Positioned(
              left: -100,
              top: -100,
              child: CircularDesign(),
            ),
            Positioned(child: CircularDesign(),
            top: 250, right: -200,
            ),
            Positioned(child: CircularDesign(),
            left: -50, bottom: -50,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'WallWonders',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<DocumentSnapshot>> fetchDataFood() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('wallpaper_info')
          .where("category", isEqualTo: 'Food')
          .get();

      List<DocumentSnapshot> docs = querySnapshot.docs;
      return docs;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<DocumentSnapshot>> fetchDataTravel() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('wallpaper_info')
          .where("category", isEqualTo: 'Travel')
          .get();

      List<DocumentSnapshot> docs = querySnapshot.docs;
      return docs;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<DocumentSnapshot>> fetchDataWildlife() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('wallpaper_info')
          .where("category", isEqualTo: 'Wildlife')
          .get();

      List<DocumentSnapshot> docs = querySnapshot.docs;
      return docs;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}

class CircularDesign extends StatelessWidget {
  const CircularDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade100,
        borderRadius: BorderRadius.circular(200),
      ),
    );
  }
}
