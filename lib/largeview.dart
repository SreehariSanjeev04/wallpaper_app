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
  @override
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(child: 
      Column(
        children: [
          Image.network(widget.imageURL),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: (){
            showDialog(context: (context), builder: (context){
              return  AlertDialog(
                title: Text('Confirm'),
                content: Text('Choose an option'),
                actions: [
                  TextButton(onPressed: (){
                    setWallpaperFromFile(0,widget.imageURL);
                  }, child: Text('Home Screen')),
                  TextButton(onPressed: (){
                    setWallpaperFromFile(1, widget.imageURL);
                  }, child: Text('Lock Screen')),
                  TextButton(onPressed: (){
                    setWallpaperFromFile(2, widget.imageURL);
                  }, child: Text('Both'))
                ],
              );
            });
          }, child: Text('Set as wallpaper'))
        ],
      ),),
    );
  }
}