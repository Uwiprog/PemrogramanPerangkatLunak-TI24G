import '../../domain/models/transaksi.dart';
import '../../domain/kas_calculator.dart';

class TransaksiRepository {
  final List<Transaksi> _transaksiList = [];

  List<Transaksi> getTransaksiList() => List.unmodifiable(_transaksiList);

  bool tambahTransaksi(Transaksi transaksi) {
    if (KasCalculator.validasiTransaksiBaru(_transaksiList, transaksi)) {
      _transaksiList.add(transaksi);
      return true;
    }
    return false;
  }

  void hapusTransaksi(String id) {
    _transaksiList.removeWhere((t) => t.id == id);
  }
}