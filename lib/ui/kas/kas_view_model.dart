import 'package:flutter/foundation.dart';
import '../../domain/models/transaksi.dart';
import '../../data/repositories/transaksi_repository.dart';
import '../../domain/kas_calculator.dart';

class KasViewModel extends ChangeNotifier {
  final TransaksiRepository _repository = TransaksiRepository();

  List<Transaksi> get transaksiList => _repository.getTransaksiList();

  double get totalPemasukan => KasCalculator.totalPemasukan(transaksiList);
  double get totalPengeluaran => KasCalculator.totalPengeluaran(transaksiList);
  double get saldo => KasCalculator.hitungSaldo(transaksiList);

  bool tambahTransaksi({
    required String keterangan,
    required double nominal,
    required JenisTransaksi jenis,
  }) {
    final transaksiBaru = Transaksi(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      keterangan: keterangan,
      nominal: nominal,
      jenis: jenis,
      tanggal: DateTime.now(),
    );

    bool berhasil = _repository.tambahTransaksi(transaksiBaru);
    if (berhasil) {
      notifyListeners();
    }
    return berhasil;
  }

  void hapusTransaksi(String id) {
    _repository.hapusTransaksi(id);
    notifyListeners();
  }
}