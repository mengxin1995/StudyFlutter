import 'dart:io';

var outputDir = Directory("output");
var targetDir = Directory("../flutter-aar");

Future main() async {
  List<AAR> list = [];
  outputDir.deleteSync(recursive: true);
  outputDir.createSync(recursive: true);
  var file = File(".flutter-plugins");
  var plugins = file.readAsLinesSync();
  for (var value in plugins) {
    if (value.trim().isEmpty) {
      continue;
    }
    var splitArr = value.split("=");
    var name = splitArr[0];
    var path = splitArr[1];

    var aar = handlePlugin(name, path);
    list.add(aar);
  }

  var aar = await handleFlutter();
  list.add(aar);

  handleAAR(list);
}

void handleAAR(List<AAR> list) {
  targetDir.deleteSync(recursive: true);
  targetDir.createSync();
  list.forEach((aar) {
    var targetPath = "${targetDir.path}/${aar.aarName}";
    var targetFile = aar.file.copySync(targetPath);
    print(
        '\ncopy "${aar.file.absolute.path}" to "${targetFile.absolute.path}"');
  });
}

AAR handlePlugin(String name, String path) {
  var result = Process.runSync("./gradlew", ["$name:assRel"],
      workingDirectory: ".android");
  print(result.stdout);

  var aarFile = File("$path/android/build/outputs/aar/$name-release.aar");
  var aarName = aarFile.path.split("/").last;
  var pathName = "${outputDir.path}/$aarName";
  var targetFile = aarFile.copySync(pathName);
  return AAR()
    ..file = targetFile
    ..aarName = aarName;
}

Future<AAR> handleFlutter() async {
  var processResult = await Process.run(
    "flutter",
    ["build", "apk"],
    workingDirectory: ".",
    runInShell: true,
  );

  print(processResult.stdout);

  var name = "flutter-release.aar";

  var file = File(".android/Flutter/build/outputs/aar/flutter-release.aar");
  var target = file.copySync("${outputDir.path}/$name");

  return AAR()
    ..file = target
    ..aarName = name;
}

class AAR {
  String aarName;
  File file;

  String get noExtensionAarName => aarName.split(".").first;

  @override
  String toString() {
    return 'AAR{aarName: $aarName, file: $file, noExtensionAarName: $noExtensionAarName}';
  }
}
