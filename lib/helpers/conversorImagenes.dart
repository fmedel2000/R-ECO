import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

Future<Uint8List> conversorImagenes(String path, {int width = 100}) async {
  final datos = await rootBundle.load(path);
  final bytes = datos.buffer.asUint8List();
  final codec = await ui.instantiateImageCodec(bytes, targetWidth: width);
  final frame = await codec.getNextFrame();
  final nuevo = await frame.image.toByteData(format: ui.ImageByteFormat.png);
  return nuevo!.buffer.asUint8List();
}
