import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_9/ui/kas/tambah_transaksi_screen.dart';
import 'package:flutter_application_9/ui/kas/kas_view_model.dart';

void main() {
  testWidgets('Test komponen form TambahTransaksiScreen dirender dengan benar', (WidgetTester tester) async {
    final viewModel = KasViewModel();
    await tester.pumpWidget(MaterialApp(home: TambahTransaksiScreen(viewModel: viewModel)));

    expect(find.byKey(const Key('input_keterangan')), findsOneWidget);
    expect(find.byKey(const Key('input_nominal')), findsOneWidget);
    expect(find.byKey(const Key('dropdown_jenis')), findsOneWidget);
    expect(find.byKey(const Key('btn_simpan')), findsOneWidget);
  });

  testWidgets('Test validasi gagal jika form kosong dan tombol simpan ditekan', (WidgetTester tester) async {
    final viewModel = KasViewModel();
    await tester.pumpWidget(MaterialApp(home: TambahTransaksiScreen(viewModel: viewModel)));

    // Tekan tombol simpan tanpa isi apa-apa
    await tester.tap(find.byKey(const Key('btn_simpan')));
    await tester.pump();

    // Pastikan pesan error validasi muncul
    expect(find.text('Keterangan tidak boleh kosong'), findsOneWidget);
    expect(find.text('Nominal wajib diisi'), findsOneWidget);
  });
}