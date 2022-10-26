import 'package:flutter/cupertino.dart';
import 'package:qrreader/models/scan_models.dart';
import 'package:qrreader/provider/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = "http";

  Future<ScanModel> addScan(String valor) async {
    final newScan = ScanModel(valor: valor);

    newScan.title = "Hold to set title";
    final scanId = await DbProvider.db.newRawScan(newScan);
    newScan.id = scanId;

    if (selectedType == newScan.tipo) {
      scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  loadScans() async {
    final allscans = await DbProvider.db.getAllHistory();
    scans = [...allscans];
    notifyListeners();
  }

  loadByType(String type) async {
    final allscans = await DbProvider.db.getScansByType(type);
    scans = [...allscans];
    notifyListeners();
  }

  deleteAll() async {
    await DbProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  deleteById(int? id) async {
    await DbProvider.db.deleteScan(id);
  }

  update(ScanModel scan) async {
    await DbProvider.db.updateScan(scan);
  }
}
