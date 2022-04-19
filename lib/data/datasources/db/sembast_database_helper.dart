import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastDatabaseHelper {
  static Database? database;

  static getDatabase() async {
    if (database == null) {
      DatabaseFactory dbFactory = databaseFactoryIo;
      WidgetsFlutterBinding.ensureInitialized();
      var appDocumentDirectory = await getApplicationDocumentsDirectory();
      var path = join(appDocumentDirectory.path, 'flutter_expert.db');
      database = await dbFactory.openDatabase(path);
    }
    return database;
  }
}
