import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastDatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      DatabaseFactory dbFactory = databaseFactoryIo;
      WidgetsFlutterBinding.ensureInitialized();
      var appDocumentDirectory = await getApplicationDocumentsDirectory();
      var path = join(appDocumentDirectory.path, 'flutter_expert.db');
      _database = await dbFactory.openDatabase(path);
    }
    return Future.value(_database);
  }
}
