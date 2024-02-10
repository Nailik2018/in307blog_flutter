import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class OfflineDB{
  final path;
  final StoreRef<int, Map<String, dynamic>> _store =
  intMapStoreFactory.store('blogs');
  OfflineDB({required this.path});

  Future<Database> getDatabase() async {
    final db = await databaseFactoryIo.openDatabase(this.path);
    print("Database path: ${this.path}");
    return db;
  }

  Future<void> createDatabase(data) async {
    final dbFactory = databaseFactoryIo;
    final db = await dbFactory.openDatabase(this.path);
    for(var blog in data){
      await _store.record(blog['id']).put(await getDatabase(), blog);
    }
    await db.close();
  }

  Future<void> delDatabase() async {
    await databaseFactoryIo.deleteDatabase(this.path);
  }
}