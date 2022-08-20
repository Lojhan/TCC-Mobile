import 'dart:io';

import 'package:image_picker/image_picker.dart';

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
