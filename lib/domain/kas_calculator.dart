import 'models/transaksi.dart';

class KasCalculator {
  static double totalPemasukan(List<Transaksi> list) {
    return list
        .where((t) => t.jenis == JenisTransaksi.pemasukan)
        .fold(0.0, (sum, t) => sum + t.nominal);
  }

  static double totalPengeluaran(List<Transaksi> list) {
    return list
        .where((t) => t.jenis == JenisTransaksi.pengeluaran)
        .fold(0.0, (sum, t) => sum + t.nominal);
  }

  static double hitungSaldo(List<Transaksi> list) {
    return totalPemasukan(list) - totalPengeluaran(list);
  }

  static bool validasiTransaksiBaru(List<Transaksi> listSekarang, Transaksi baru) {
    // Tolak nominal nol atau negatif
    if (baru.nominal <= 0) return false;

    // Jika pengeluaran, tolak jika melebihi saldo saat ini
    if (baru.jenis == JenisTransaksi.pengeluaran) {
      double saldoSaatIni = hitungSaldo(listSekarang);
      if (baru.nominal > saldoSaatIni) return false;
    }

    return true;
  }
}