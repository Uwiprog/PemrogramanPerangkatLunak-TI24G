import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_application_9/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Integration Test: Tambah dua transaksi dan cek saldo akhir', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // 1. Klik Floating Action Button untuk buka halaman Tambah Transaksi
    final fab = find.byKey(const Key('btn_tambah_transaksi'));
    expect(fab, findsOneWidget);
    await tester.tap(fab);
    await tester.pumpAndSettle();

    // 2. Tambah Transaksi 1: Pemasukan 500.000
    await tester.enterText(find.byKey(const Key('input_keterangan')), 'Dana Kas Kampus');
    await tester.enterText(find.byKey(const Key('input_nominal')), '500000');
    await tester.tap(find.byKey(const Key('btn_simpan')));
    await tester.pumpAndSettle();

    // Verifikasi saldo bertambah jadi 500000 di Home Screen
    expect(find.text('Rp 500000'), findsOneWidget);

    // 3. Masuk lagi ke form tambah transaksi
    await tester.tap(find.byKey(const Key('btn_tambah_transaksi')));
    await tester.pumpAndSettle();

    // Ubah jenis ke pengeluaran (atau masukkan nominal)
    // Ketik Transaksi 2: Pengeluaran 100.000
    await tester.enterText(find.byKey(const Key('input_keterangan')), 'Beli Spanduk');
    await tester.enterText(find.byKey(const Key('input_nominal')), '100000');
    
    // Pilih dropdown jadi pengeluaran
    await tester.tap(find.byKey(const Key('dropdown_jenis')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pengeluaran').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('btn_simpan')));
    await tester.pumpAndSettle();

    // 4. Verifikasi saldo akhir menjadi 400000 (500000 - 100000)
    expect(find.text('Rp 400000'), findsOneWidget);
    expect(find.text('Dana Kas Kampus'), findsOneWidget);
    expect(find.text('Beli Spanduk'), findsOneWidget);
  });
}