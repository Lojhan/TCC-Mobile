import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

ImageProvider getImageProvider(String? path) {
  if (path == null) {
    return const AssetImage('assets/images/placeholder.png');
  }

  File f = File(path);

  if (f.path.startsWith('http')) {
    return NetworkImage(f.path);
  }

  if (f.path.startsWith('assets')) {
    return AssetImage(f.path);
  }

  if (kIsWeb) {
    return const AssetImage('assets/images/no_image.jpeg');
  }

  if (f.existsSync()) {
    return FileImage(f);
  }

  return const AssetImage('assets/images/no_image.jpeg');
}
