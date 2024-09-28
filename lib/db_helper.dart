import 'package:oak_teste/class.dart';
import 'package:oak_teste/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const create =
    """CREATE TABLE IF NOT EXISTS Produtos(id INTEGER PRIMARY KEY, nome TEXT, desc TEXT, prec REAL, dpv INTEGER)""";

openDb() async {
  var dbPath = await getDatabasesPath();
  String devicePath = join(dbPath, 'lista_produtos.db');

  Database produtos = await openDatabase(devicePath, version: 1,
      onCreate: (Database db, int v) async {
    await db.execute(create);
  });

  await produtos.close();
}

readDb() async {
  var dbPath = await getDatabasesPath();
  String devicePath = join(dbPath, 'lista_produtos.db');

  Database produtos = await openDatabase(devicePath, version: 1,
      onCreate: (Database db, int v) async {
    await db.execute(create);
  });
  List<Map> res = await produtos.rawQuery('SELECT * FROM Produtos');

  for (var el in res) {
    listaProdutos.add(
      Produto(
        id: el["id"],
        nome: el["nome"],
        desc: el["desc"],
        prec: el["prec"],
        dpv: el["dpv"] == 0 ? false : true,
      ),
    );
  }

  await produtos.close();
  listaProdutos.sort((a, b) => a.prec.compareTo(b.prec));
  return listaProdutos;
}

insertProduto(int id, String nome, desc, double prec, bool dpv) async {
  var dbPath = await getDatabasesPath();
  int tmpdpv = dpv == true ? 1 : 0;
  String devicePath = join(dbPath, 'lista_produtos.db');

  Database produtos = await openDatabase(devicePath);
  await produtos.transaction((txn) async {
    await txn.rawInsert(
      """INSERT INTO Produtos(id, nome, desc, prec, dpv) VALUES($id, "$nome", "$desc", $prec, $tmpdpv)""",
    );
  });
  await produtos.close();
  return;
}
