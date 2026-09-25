import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Flutter Sesi 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Ganti warna tema sesuai keinginan (misal: Indigo / Ungu)
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  // Fungsi Tambah
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Fungsi Kurang dengan Validasi SnackBar
  void _decrementCounter(BuildContext context) {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    } else {
      // Tampilkan SnackBar jika angka sudah 0
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Angka tidak boleh di bawah 0!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Fungsi Reset
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Menentukan warna angka berdasarkan genap atau ganjil
    bool isEven = _counter % 2 == 0;
    Color numberColor = isEven ? Colors.green : Colors.orange;

    return Scaffold(
      appBar: AppBar(
        // Ubah bagian ini dengan Nama dan NIM Anda
        title: const Text('PPM Sesi 1 - M.Dwi Haryanto (20240040174)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Kartu Identitas Mahasiswa
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/profil.jpg'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Nama: M.Dwi Haryanto', // Ganti Nama
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'NIM: 20240040174', // Ganti NIM
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Prodi/Kelas: Teknik Informatika / TI24G', // Ganti Prodi/Kelas
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            // Status Angka (Genap / Ganjil)
            Text(
              isEven ? 'Angka Genap' : 'Angka Ganjil',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: numberColor,
              ),
            ),
            const SizedBox(height: 10),

            // Tampilan Angka Counter
            Text(
              '$_counter',
              style: TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: numberColor,
              ),
            ),
            const SizedBox(height: 30),

            // Kumpulan Tombol (+, -, Reset)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tombol Kurang (-)
                FloatingActionButton(
                  onPressed: () => _decrementCounter(context),
                  tooltip: 'Kurang',
                  heroTag: 'btn_decrement',
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 15),

                // Tombol Reset
                FloatingActionButton(
                  onPressed: _resetCounter,
                  tooltip: 'Reset',
                  heroTag: 'btn_reset',
                  backgroundColor: Colors.redAccent,
                  child: const Icon(Icons.refresh, color: Colors.white),
                ),
                const SizedBox(width: 15),

                // Tombol Tambah (+)
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  tooltip: 'Tambah',
                  heroTag: 'btn_increment',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}