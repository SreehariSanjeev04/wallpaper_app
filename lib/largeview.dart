import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
class LargeView extends StatefulWidget {
  final String imageURL;
  final String title;
  const LargeView({super.key, required this.imageURL, required this.title});

  @override
  State<LargeView> createState() => _LargeViewState();
}

class _LargeViewState extends State<LargeView> {
  Future<void> setWallpaperFromFile(int value, String imageURL) async {
    bool result;
    var file = await DefaultCacheManager().getSingleFile(imageURL);
    try {
      if(value==0) {
         result = await WallpaperManager.setWallpaperFromFile(file.path,WallpaperManager.HOME_SCREEN);
      }else if(value==1){
        result = await WallpaperManager.setWallpaperFromFile(file.path, WallpaperManager.LOCK_SCREEN);
      }else{
        result = await WallpaperManager.setWallpaperFromFile(file.path, WallpaperManager.BOTH_SCREEN);
      }
    } on PlatformException {
      result = false;
    }
    if(!result){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to set wallpaper')));
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(child: 
      Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: MediaQuery.of(context).size.height*0.7,
              width: MediaQuery.of(context).size.width*0.9,
              child: Image.network(widget.imageURL,fit: BoxFit.cover,)
            
            )),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: (){
            showDialog(context: (context), builder: (context){
              return  AlertDialog(
                title: Text('Confirm'),
                content: Text('Choose an option'),
                actions: [
                  WallpaperButton(text: 'Home Screen',function: setWallpaperFromFile, imageURL: widget.imageURL, wallpaperNumber: 0),
                  WallpaperButton(text: 'Lock Screen',function: setWallpaperFromFile, imageURL: widget.imageURL, wallpaperNumber: 1),
                  WallpaperButton(text: 'Both',function: setWallpaperFromFile, imageURL: widget.imageURL, wallpaperNumber: 2)
                ],
              );
            });
          }, child: Text('Set as wallpaper'))
        ],
      ),),
    );
  }
}
class WallpaperButton extends StatelessWidget {
  final Function(int, String) function;
  final String imageURL;
  final int wallpaperNumber;
  final String text;
  const WallpaperButton({
    Key? key,
    required this.function,
    required this.imageURL,
    required this.wallpaperNumber,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        function(wallpaperNumber, imageURL);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wallpaper applied successfully!'),behavior: SnackBarBehavior.floating,backgroundColor: Colors.green,)
        );
        Navigator.of(context).pop(context);
      },
      child: Text(text), // Provide a child widget here
    );
  }
}
