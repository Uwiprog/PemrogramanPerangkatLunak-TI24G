import 'package:flutter/material.dart';
import 'kas_view_model.dart';
import '../../domain/models/transaksi.dart';

class TambahTransaksiScreen extends StatefulWidget {
  final KasViewModel viewModel;

  const TambahTransaksiScreen({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<TambahTransaksiScreen> createState() => _TambahTransaksiScreenState();
}

class _TambahTransaksiScreenState extends State<TambahTransaksiScreen> {
  final _formKey = GlobalKey<FormState>();
  final _keteranganController = TextEditingController();
  final _nominalController = TextEditingController();
  JenisTransaksi _jenisTransaksi = JenisTransaksi.pemasukan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Transaksi'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                key: const Key('input_keterangan'),
                controller: _keteranganController,
                decoration: const InputDecoration(labelText: 'Keterangan'),
                validator: (value) => value == null || value.isEmpty ? 'Keterangan tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('input_nominal'),
                controller: _nominalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Nominal (Rp)'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Nominal wajib diisi';
                  final parsed = double.tryParse(value);
                  if (parsed == null || parsed <= 0) return 'Nominal harus lebih besar dari 0';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<JenisTransaksi>(
                key: const Key('dropdown_jenis'),
                value: _jenisTransaksi,
                items: const [
                  DropdownMenuItem(value: JenisTransaksi.pemasukan, child: Text('Pemasukan')),
                  DropdownMenuItem(value: JenisTransaksi.pengeluaran, child: Text('Pengeluaran')),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _jenisTransaksi = val);
                },
                decoration: const InputDecoration(labelText: 'Jenis Transaksi'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                key: const Key('btn_simpan'),
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final nominal = double.parse(_nominalController.text);
                    bool berhasil = widget.viewModel.tambahTransaksi(
                      keterangan: _keteranganController.text,
                      nominal: nominal,
                      jenis: _jenisTransaksi,
                    );

                    if (berhasil) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Gagal: Pengeluaran melebihi saldo kas!')),
                      );
                    }
                  }
                },
                child: const Text('Simpan Transaksi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}