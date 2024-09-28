import 'package:flutter/material.dart';
import 'package:oak_teste/card.dart';
import 'package:oak_teste/db_helper.dart';
import 'package:oak_teste/form.dart';
import 'package:oak_teste/styling.dart';
import 'class.dart';
import 'package:searchable_listview/searchable_listview.dart';

List<Produto> listaProdutos = [];

void main() {
  runApp(MaterialApp(
    home: const ProdutosApp(),
    theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
      seedColor: blue,
    )),
  ));
}

class ProdutosApp extends StatefulWidget {
  const ProdutosApp({super.key});

  @override
  State<ProdutosApp> createState() => _ProdutosAppState();
}

class _ProdutosAppState extends State<ProdutosApp> {
  bool filter = true;
  Future loadDb = readDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "PRODUTOS",
          style: appbarTitle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                filter = !filter;
              });
            }, //TODO
            icon: Icon(
              filter == true ? Icons.arrow_downward : Icons.arrow_upward,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormPage()),
              ).then((value) {
                setState(() {});
              });
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: loadDb,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SearchableList<Produto>(
              initialList: filter == true
                  ? listaProdutos
                  : listaProdutos.reversed.toList(),
              filter: (value) => listaProdutos
                  .where(
                    (el) => el.nome.toLowerCase().contains(value.toLowerCase()),
                  )
                  .cast<Produto>()
                  .toList(),
              emptyWidget: emptyWidget,
              inputDecoration: search,
              cursorColor: blue,
              itemBuilder: (Produto produto) {
                return FractionallySizedBox(
                  widthFactor: .95,
                  child: makeCards(produto),
                );
              },
              closeKeyboardWhenScrolling: true,
            );
          },
        ),
      ),
    );
  }
}

Widget emptyWidget = const Center(
  child: Text("Nenhum produto encontrado."),
);
