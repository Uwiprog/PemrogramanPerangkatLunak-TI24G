import 'package:flutter/material.dart';
import '../models/tour_package.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _participantsController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  int _totalParticipants = 0;

  @override
  void initState() {
    super.initState();
    // Mendengarkan perubahan pada input jumlah peserta secara real-time
    _participantsController.addListener(_updateTotalPrice);
  }

  void _updateTotalPrice() {
    setState(() {
      _totalParticipants = int.tryParse(_participantsController.text) ?? 0;
    });
  }

  @override
  void dispose() {
    _participantsController.dispose();
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // Fungsi untuk memunculkan kalender (DatePicker)
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TourPackage package = ModalRoute.of(context)!.settings.arguments as TourPackage;
    
    // Hitung total harga
    double totalPrice = package.price * _totalParticipants;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final bool? exit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Batalkan Pemesanan?'),
            content: const Text('Apakah Anda yakin ingin keluar dari halaman pemesanan?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Tidak'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Ya'),
              ),
            ],
          ),
        );

        if (exit == true && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Booking: ${package.title}'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Info Harga Satuan
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Harga per Peserta: Rp ${package.price.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Pemesan',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _participantsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Jumlah Peserta',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jumlah peserta harus diisi';
                    }
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return 'Masukkan angka yang valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Keberangkatan',
                    hintText: 'Pilih tanggal keberangkatan',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tanggal keberangkatan harus dipilih';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                // Bagian Tampilan Total Harga Real-Time
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Harga:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Rp ${totalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String pesan = 'Pemesanan ${_nameController.text} untuk ${package.title} (${_totalParticipants} orang) dengan total Rp ${totalPrice.toStringAsFixed(0)} berhasil!';
                      Navigator.pop(context, pesan);
                    }
                  },
                  child: const Text('Konfirmasi Pemesanan', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}