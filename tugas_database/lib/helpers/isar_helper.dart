import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'database_helper.dart';

class IsarHelper {
  late Future<Isar> db;

  IsarHelper() {
    db = _initDB();
  }

  // Fungsi untuk membuka koneksi database Isar (Wajib ada)
  Future<Isar> _initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      // CatatanSchema adalah variabel yang terbuat otomatis di file .g.dart
      return await Isar.open([CatatanSchema], directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  // =======================================================
  // KODE CRUD MILIKMU DILETAKKAN DI DALAM FUNGSI-FUNGSI INI
  // =======================================================

  // 1. CREATE (Menyimpan data)
  Future<void> tambahCatatan(Catatan catatanBaru) async {
    final isar = await db; // Panggil instance database

    // --> Potongan kode CREATE milikmu diletakkan di sini:
    await isar.writeTxn(() async {
      await isar.catatans.put(catatanBaru);
    });
  }

  // 2. READ (Membaca semua data)
  Future<List<Catatan>> ambilSemuaCatatan() async {
    final isar = await db;

    // --> Potongan kode READ milikmu diletakkan di sini:
    final semuaCatatan = await isar.catatans.where().findAll();

    return semuaCatatan; // Kembalikan datanya ke UI
  }

  // 3. DELETE (Menghapus data berdasarkan ID)
  Future<void> hapusCatatan(int idCatatan) async {
    final isar = await db;

    // --> Potongan kode DELETE milikmu diletakkan di sini:
    await isar.writeTxn(() async {
      await isar.catatans.delete(idCatatan);
    });
  }
}
