import 'package:flutter/material.dart';

class getPremium extends StatefulWidget {
  getPremium({super.key});

  @override
  State<getPremium> createState() => _getPremiumState();
}

class _getPremiumState extends State<getPremium> {
  final List<String> prices = ['₹100','₹200','₹300','₹400'];
  final List<String> timePeriod = ['1 month','3 months', '6 months', '1 year'];
  String selectedPrice = '';
  List<bool> membershipSelected = [false,false,false,false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon:const Icon(Icons.arrow_back_ios_new),color: Colors.white,onPressed:()=> Navigator.of(context).pop(context),),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Align(child: Image.network('https://st2.depositphotos.com/28265962/50218/v/600/depositphotos_502180846-stock-video-diamond-icon-with-glitch-art.jpg'),alignment: Alignment.topCenter,),
          Align(child: Column(children: [
            const Text('Premium Subscription Allows', style: TextStyle(color: Colors.white),),
            const ListTile(
              leading: Icon(Icons.check, color: Colors.green,),
              title: Text('Access to premium wallpapers',style: TextStyle(color: Colors.white),),
            ),
            const ListTile(
              leading: Icon(Icons.check, color: Colors.green,),
              title: Text('Access to exclusive auto wallpaper settings',style: TextStyle(color: Colors.white),),
            ),
            Container(
              height: 250,
              width: 250,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: prices.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            membershipSelected[index] = !membershipSelected[index];
                          });
                          String sentence = membershipSelected[index]?'selected':'deactivated';
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(duration: Duration(seconds: 1),content: Text('Membership' + ' ${sentence}' + ': ' + prices[index]),behavior: SnackBarBehavior.floating,backgroundColor: membershipSelected[index]?Colors.green:Colors.red,)
                          );
                        },
                        child: priceContainer(price: prices[index],duration: timePeriod[index],));
                    },
                
              ),
            )

          ],),alignment: Alignment.center,)
        ],
      ),
    );
  }
}
class priceContainer extends StatelessWidget {
  final String price;
  final String duration;
  const priceContainer({super.key, required this.price, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(price, style: const TextStyle(color: Colors.white),),
            Text(duration, style: const TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}