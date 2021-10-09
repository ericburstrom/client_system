part of '../main.dart';

class FileHandler {
  var FileSettings = "user_loginSettings.json";
  var FileHighscores = "highscores.json";

  Future<String> LocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> LocalFile(String fileName) async {
    final path = await LocalPath();
    print(path);
    return File('$path/' + fileName);
  }

//Future<Map<String, dynamic>> readFile(String fileName) async {
  Future ReadFile(String fileName) async {
    var _json;
    try {
      final file = await LocalFile(fileName);
      // Read the file
      var contents = await file.readAsString();
      _json = jsonDecode(contents);
      return _json;
    } catch (e) {
      // If encountering an error, return 0
      print('no file');
      rethrow;
    }
  }

//Future<File> writeFile(Map<String, dynamic> _json, fileName) async {
  Future<File> SaveFile(var _json, fileName) async {
    //fileFileName = fileName;
    try {
      final file = await LocalFile(fileName);
      var _jsonString = jsonEncode(_json);
      // Write the file
      return file.writeAsString(_jsonString);
    } catch (e) {
      print("error writing file");
      throw (e);
    }
  }
}
