import 'package:flutter/material.dart';

class WallPaperDisplay extends StatefulWidget {
  const WallPaperDisplay({Key? key}) : super(key: key);

  @override
  State<WallPaperDisplay> createState() => _WallPaperDisplayState();
}

class _WallPaperDisplayState extends State<WallPaperDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Wallpaper'),
    );
  }
}
