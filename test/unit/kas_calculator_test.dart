import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_9/domain/kas_calculator.dart';
import 'package:flutter_application_9/domain/models/transaksi.dart';

void main() {
  group('KasCalculator Unit Tests', () {
    test('1. List kosong menghasilkan total pemasukan 0', () {
      expect(KasCalculator.totalPemasukan([]), 0.0);
    });

    test('2. List kosong menghasilkan total pengeluaran 0', () {
      expect(KasCalculator.totalPengeluaran([]), 0.0);
    });

    test('3. List kosong menghasilkan saldo 0', () {
      expect(KasCalculator.hitungSaldo([]), 0.0);
    });

    test('4. Perhitungan total pemasukan dan saldo dengan benar', () {
      final list = [
        Transaksi(id: '1', keterangan: 'Sponsorship', nominal: 500000, jenis: JenisTransaksi.pemasukan, tanggal: DateTime.now()),
        Transaksi(id: '2', keterangan: 'Iuran Wajib', nominal: 100000, jenis: JenisTransaksi.pemasukan, tanggal: DateTime.now()),
      ];
      expect(KasCalculator.totalPemasukan(list), 600000.0);
      expect(KasCalculator.hitungSaldo(list), 600000.0);
    });

    test('5. Validasi tolak nominal nol atau negatif', () {
      final list = <Transaksi>[];
      final txNol = Transaksi(id: '3', keterangan: 'Nol', nominal: 0, jenis: JenisTransaksi.pemasukan, tanggal: DateTime.now());
      final txNegatif = Transaksi(id: '4', keterangan: 'Negatif', nominal: -5000, jenis: JenisTransaksi.pemasukan, tanggal: DateTime.now());

      expect(KasCalculator.validasiTransaksiBaru(list, txNol), false);
      expect(KasCalculator.validasiTransaksiBaru(list, txNegatif), false);
    });

    test('6. Validasi tolak pengeluaran jika melebihi saldo', () {
      final list = [
        Transaksi(id: '1', keterangan: 'Saldo Awal', nominal: 100000, jenis: JenisTransaksi.pemasukan, tanggal: DateTime.now()),
      ];
      final txLebih = Transaksi(id: '2', keterangan: 'Beli ATK', nominal: 150000, jenis: JenisTransaksi.pengeluaran, tanggal: DateTime.now());

      expect(KasCalculator.validasiTransaksiBaru(list, txLebih), false);
    });

    test('7. Nilai Batas: Pengeluaran tepat sama dengan saldo diizinkan', () {
      final list = [
        Transaksi(id: '1', keterangan: 'Saldo Awal', nominal: 100000, jenis: JenisTransaksi.pemasukan, tanggal: DateTime.now()),
      ];
      final txPas = Transaksi(id: '2', keterangan: 'Beli Konsumsi', nominal: 100000, jenis: JenisTransaksi.pengeluaran, tanggal: DateTime.now());

      expect(KasCalculator.validasiTransaksiBaru(list, txPas), true);
    });

    test('8. Perhitungan saldo setelah pengeluaran valid', () {
      final list = [
        Transaksi(id: '1', keterangan: 'Pemasukan', nominal: 200000, jenis: JenisTransaksi.pemasukan, tanggal: DateTime.now()),
        Transaksi(id: '2', keterangan: 'Pengeluaran', nominal: 50000, jenis: JenisTransaksi.pengeluaran, tanggal: DateTime.now()),
      ];
      expect(KasCalculator.hitungSaldo(list), 150000.0);
    });
  });
}