import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

import 'screen_shot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Save Widget as PNG'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await saveWidgetAsImage();
            },
            child: const Text('Save Widget as PNG'),
          ),
        ),
      ),
    );
  }
}

Future<void> saveWidgetAsImage() async {
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? screenshot = await screenshotController.captureFromWidget(
    MyWidget(),
    delay: const Duration(milliseconds: 10),
    pixelRatio: 3.0,
  );

  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/widget_image1.png';
  File file = File(path);
  await file.writeAsBytes(screenshot);
  print('Image saved to $path');
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Capture me!',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
