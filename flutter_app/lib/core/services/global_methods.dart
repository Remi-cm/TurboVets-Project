import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

newLog(dynamic object) {
  if (kDebugMode) log(object.toString());
}

newPrint(dynamic object) {
  if (kDebugMode) print(object.toString());
}

Future<bool?> playAssetAudio(String fileName) async {
  var audioPlayer = AudioPlayer();
  await audioPlayer.setAsset("assets/audio/$fileName");
  await audioPlayer.play().then((value) {
    //audioPlayer.dispose();
    return true;
  });
  return false;
}


//DIMENSIONS
double wv(BuildContext context) => MediaQuery.of(context).size.width/100;
double hv(BuildContext context) => MediaQuery.of(context).size.height/100;

//PATHS
String imageAsset(String asset) => "assets/images/$asset";
String iconAsset(String asset) => "assets/icons/$asset";

// MediaQuery
isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;