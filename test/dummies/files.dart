import 'dart:io';

import 'package:camera/camera.dart';

import 'strings.dart';

class FileDummy {
  static File get file {
    final file = File(StringDummy.filePath);
    file.createSync(recursive: true);
    return file;
  }

  static Future<XFile> get xfile async {
    XFile xfile = XFile(StringDummy.filePath);
    await xfile.saveTo(StringDummy.filePath);
    return xfile;
  }
}
