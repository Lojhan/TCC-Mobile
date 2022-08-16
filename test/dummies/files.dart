import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';

class FileDummy {
  static File get file => File('file');

  static XFile get xfile => XFile.fromData(Uint8List.fromList([2]), length: 1);
}
