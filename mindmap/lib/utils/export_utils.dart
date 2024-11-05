import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveImage(Uint8List imageBytes) async {
  final result = await ImageGallerySaver.saveImage(imageBytes);
  print(result);
}