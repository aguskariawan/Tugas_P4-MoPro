import 'package:flutter/material.dart';
import 'helpers/isar_helper.dart';
import 'helpers/database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HalamanTugas());
  }
}

class HalamanTugas extends StatefulWidget {
  const HalamanTugas({super.key});

  @override
  State<HalamanTugas> createState() => _HalamanTugasState();
}

class _HalamanTugasState extends State<HalamanTugas> {
  final isarHelper = IsarHelper();

  void simpanData() async {
    final catatanBaru = Catatan()
      ..judul = "Tugas P4"
      ..deskripsi = "Eksplorasi Isar Database";

    await isarHelper.tambahCatatan(catatanBaru);

    // Mencegah warning context melintasi async gap
    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Data berhasil disimpan!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Uji Coba Isar")),
      body: Center(
        child: ElevatedButton(
          onPressed: simpanData,
          child: const Text("Simpan Data ke Isar"),
        ),
      ),
    );
  }
}
