enum JenisTransaksi { pemasukan, pengeluaran }

class Transaksi {
  final String id;
  final String keterangan;
  final double nominal;
  final JenisTransaksi jenis;
  final DateTime tanggal;

  Transaksi({
    required this.id,
    required this.keterangan,
    required this.nominal,
    required this.jenis,
    required this.tanggal,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'keterangan': keterangan,
        'nominal': nominal,
        'jenis': jenis.index,
        'tanggal': tanggal.toIso8601String(),
      };

  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        id: json['id'],
        keterangan: json['keterangan'],
        nominal: json['nominal'],
        jenis: JenisTransaksi.values[json['jenis']],
        tanggal: DateTime.parse(json['tanggal']),
      );
}