import 'package:qrreader/models/scan_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbProvider {
  late Database _database;
  static final DbProvider db = DbProvider._();

  DbProvider._();

  Future<Database> get database async {
    _database = await initDatabase();

    return _database;
  }

  Future<Database> initDatabase() async {
    var documentDirectory = await getDatabasesPath();
    String path = join(documentDirectory, "Scansdb.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(''' 
            CREATE TABLE SCANS(
              id INTEGER PRIMARY KEY,
              tipo TEXT,
              valor TEXT,
              title TEXT
            )
       ''');
    });
  }

  Future<int> newRawScan(ScanModel scanRecord) async {
    final db = await database;

    final res = await db.insert("SCANS", scanRecord.toMap());

    return res;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await database;

    final res = await db.query("SCANS", where: "id = ?", whereArgs: [id]);
    return ScanModel.fromJson(res.first);
  }

  Future<List<ScanModel>> getAllHistory() async {
    final db = await database;

    final List res = await db.query("SCANS");
    return res.map((e) => ScanModel.fromJson(e)).toList();
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;

    final List res =
        await db.query("SCANS", where: "tipo = ?", whereArgs: [type]);
    return res.map((e) => ScanModel.fromJson(e)).toList();
  }

  Future<int> updateScan(ScanModel scanRecord) async {
    final db = await database;

    final res = await db.update("SCANS", scanRecord.toMap(),
        where: "id = ?", whereArgs: [scanRecord.id]);
    return res;
  }

  Future<int> deleteScan(int? id) async {
    final db = await database;

    final res = await db.delete("SCANS", where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;

    final res = await db.rawDelete("""
        DELETE FROM SCANS
    """);
    return res;
  }
}
