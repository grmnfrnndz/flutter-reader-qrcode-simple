import 'package:flutter/foundation.dart';
import 'package:qr_app/presentation/providers/providers.dart';

import '../../infrastructure/models/models.dart';


class ScanListProvider extends ChangeNotifier {


  List<ScanModel>  scans = [];
  String typeSelected = ScanType.http.value;


  Future<ScanModel> addScan(String value) async {

    final scan = ScanModel(value: value);
    final idScan = await DBProvider.db.addScan(scan);

    scan.id = idScan;

    // only selectedType and scantype are equal: add scan (must be equal view selected)
    if (typeSelected == scan.type!.value) {
      scans.add(scan);
      notifyListeners();
    }

    return scan;
  }

  Future<void> loadScans() async {
    final scansDB = await DBProvider.db.getAllScans();
    scans = [...scansDB];
    notifyListeners();
  }

  Future<void> loadScansByType(ScanType type) async {
    final scansDB = await DBProvider.db.getScansByType(type);
    scans = [...scansDB];
    typeSelected = type.value;
    notifyListeners();
  }


  Future<void> deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  Future<void> deleteScanById(int scanId) async {
    scans.removeWhere((scan) => scan.id == scanId);
    final scandDB = await DBProvider.db.getScanById(scanId);
    if (scandDB != null) {
      await DBProvider.db.deleteScan(scandDB.id!);
      await loadScansByType(typeSelected == 'http'? ScanType.http:ScanType.geo);
      notifyListeners();
    }
  }

}
