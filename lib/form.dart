import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:oak_teste/class.dart';
import 'package:oak_teste/db_helper.dart';
import 'package:oak_teste/main.dart';
import 'package:oak_teste/styling.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

bool isdpv = true;
TextEditingController nomeController = TextEditingController();
TextEditingController descController = TextEditingController();
TextEditingController precController = TextEditingController();

final CurrencyTextInputFormatter formatter =
    CurrencyTextInputFormatter.currency(
  decimalDigits: 2,
  symbol: "R\$ ",
);

class _FormPageState extends State<FormPage> {
  final createFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey[200]),
        backgroundColor: blue,
        centerTitle: true,
        title: Text(
          "CRIAR PRODUTO",
          style: criarProduto,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Form(
                key: createFormKey,
                child: Column(
                  children: [
                    field("Nome", 0, nomeController),
                    field("Descrição", 1, descController),
                    field("Preço", 2, precController),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 25.0),
                child: const Text("Produto disponível para venda?"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isdpv = false;
                      });
                    },
                    style: isdpv == false ? dpvSelectedStyle : null,
                    child: const Text("NÃO"),
                  ),
                  const VerticalDivider(),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isdpv = true;
                      });
                    },
                    style: isdpv == true ? dpvSelectedStyle : null,
                    child: const Text("SIM"),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 20,
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      nomeController.text = "";
                      descController.text = "";
                      precController.text = "";
                      isdpv = true;
                      Navigator.pop(context);
                    },
                    child: const Text("CANCELAR")),
                const VerticalDivider(),
                ElevatedButton(
                    onPressed: () {
                      if (createFormKey.currentState!.validate()) {
                        DateTime base = DateTime.now();
                        String tmp =
                            "${base.day}${base.millisecond}${listaProdutos.length + 1}";

                        int id = int.parse(tmp);
                        String nome = nomeController.text;
                        String desc = descController.text;
                        double prec = formatter.getDouble();
                        bool dpv = isdpv;

                        listaProdutos.add(
                          Produto(
                            id: id,
                            nome: nome,
                            desc: desc,
                            prec: prec,
                            dpv: dpv,
                          ),
                        );

                        insertProduto(id, nome, desc, prec, dpv);

                        nomeController.text = "";
                        descController.text = "";
                        precController.text = "";
                        isdpv = true;

                        Navigator.pop(context);
                      }
                    },
                    child: const Text("CRIAR")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget field(String label, int f, TextEditingController c) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
    child: TextFormField(
      controller: c,
      validator: (value) {
        if (value == null || value.isEmpty) {
          if (f == 0) {
            return "Insira o nome do produto";
          } else if (f == 1) {
            return "Insira a descrição do produto";
          } else {
            return "Valor do produto não pode estar vazio";
          }
        }

        return null;
      },
      decoration: createDecor(label),
      inputFormatters: f == 2
          ? [
              formatter,
            ]
          : null,
      keyboardType: f != 2 ? TextInputType.name : TextInputType.number,
    ),
  );
}
