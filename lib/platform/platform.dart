import 'dart:io' as io;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

Future<io.Directory> appDocumentsDir() async =>
    await getApplicationDocumentsDirectory();

Future<io.File> readFileTestJson() async {
  if (io.Platform.isIOS || io.Platform.isLinux || io.Platform.isAndroid) {
    var dir = (await appDocumentsDir()).path;

    if (io.File("$dir/test.json").existsSync()) {
      return io.File("$dir/test.json");
    }

    var byte = await rootBundle.load("test/test.json");
    io.File file = io.File("$dir/test.json");
    file.writeAsBytesSync(byte.buffer.asInt8List());

    return file;
  }

  return io.File("./test/test.json");
}

Future<io.File> readFileMenuPlanJson() async {
  if (io.Platform.isIOS || io.Platform.isLinux || io.Platform.isAndroid) {
    var dir = (await appDocumentsDir()).path;

    if (io.File("$dir/MenuPlan.json").existsSync()) {
      print("object exist");
      return io.File("$dir/MenuPlan.json");
    }
    var byte = await rootBundle.load("test/MenuPlan.json");
    io.File file = io.File("$dir/MenuPlan.json");
    file.writeAsBytesSync(byte.buffer.asInt8List());

    return file;
  }

  return io.File("./test/MenuPlan.json");
}

Future<io.File> readFileBaskedId() async {
  if (io.Platform.isIOS || io.Platform.isLinux || io.Platform.isAndroid) {
    var dir = (await appDocumentsDir()).path;

    if (io.File("$dir/BaskedId.txt").existsSync()) {
      print("object exist");
      return io.File("$dir/BaskedId.txt");
    }
    var byte = await rootBundle.load("test/BaskedId.txt");
    io.File file = io.File("$dir/BaskedId.txt");
    file.writeAsBytesSync(byte.buffer.asInt8List());

    return file;
  }

  return io.File("./test/BaskedId.txt");
}
