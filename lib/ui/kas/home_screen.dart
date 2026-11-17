import 'package:flutter/material.dart';
import 'kas_view_model.dart';
import '../../domain/models/transaksi.dart';
import 'tambah_transaksi_screen.dart';

class HomeScreen extends StatelessWidget {
  final KasViewModel viewModel;

  const HomeScreen({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NusaKas Himpunan'),
        backgroundColor: Colors.blue,
      ),
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (context, child) {
          return Column(
            children: [
              // Kartu Ringkasan Saldo
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  children: [
                    const Text('Saldo Kas Saat Ini', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(
                      'Rp ${viewModel.saldo.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('Pemasukan', style: TextStyle(color: Colors.green)),
                            Text('Rp ${viewModel.totalPemasukan.toStringAsFixed(0)}',
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Pengeluaran', style: TextStyle(color: Colors.red)),
                            Text('Rp ${viewModel.totalPengeluaran.toStringAsFixed(0)}',
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Daftar Transaksi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 8),
              // List Transaksi dengan Dismissible
              Expanded(
                child: viewModel.transaksiList.isEmpty
                    ? const Center(child: Text('Belum ada transaksi tercatat.'))
                    : ListView.builder(
                        itemCount: viewModel.transaksiList.length,
                        itemBuilder: (context, index) {
                          final item = viewModel.transaksiList[index];
                          final isPemasukan = item.jenis == JenisTransaksi.pemasukan;
                          return Dismissible(
                            key: Key(item.id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (direction) {
                              viewModel.hapusTransaksi(item.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${item.keterangan} dihapus')),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: isPemasukan ? Colors.green.shade100 : Colors.red.shade100,
                                  child: Icon(
                                    isPemasukan ? Icons.arrow_downward : Icons.arrow_upward,
                                    color: isPemasukan ? Colors.green : Colors.red,
                                  ),
                                ),
                                title: Text(item.keterangan),
                                subtitle: Text(item.tanggal.toLocal().toString().split(' ')[0]),
                                trailing: Text(
                                  '${isPemasukan ? "+ " : "- "}Rp ${item.nominal.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    color: isPemasukan ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('btn_tambah_transaksi'),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahTransaksiScreen(viewModel: viewModel),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}