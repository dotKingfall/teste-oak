import 'package:flutter/material.dart';
import 'package:oak_teste/class.dart';
import 'package:oak_teste/styling.dart';

Widget makeCards(Produto produto) {
  return Card(
    child: ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 100),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            height: 50,
            width: 50,
            child: Center(
              child: Column(
                children: [
                  Text(
                    "FOTO " "${produto.id}",
                    style: TextStyle(color: blue, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 53.0),
                    child: Text(
                      "NOME:",
                      style: cardDesc,
                    ),
                  ),
                  Text(
                    produto.nome,
                    style: info,
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      "DESCRIÇÃO:",
                      style: cardDesc,
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      produto.desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 45.0),
                    child: Text(
                      "VALOR: ",
                      style: cardDesc,
                    ),
                  ),
                  Text("${produto.prec}"),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 62.0),
                    child: Text(
                      "DPV: ",
                      style: cardDesc,
                    ),
                  ),
                  Text(produto.dpv == true ? "SIM" : "NÃO"),
                ],
              )
            ],
          ),
        ],
      ),
    ),
  );
}
