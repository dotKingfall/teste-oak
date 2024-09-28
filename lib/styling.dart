import 'package:flutter/material.dart';

Color blue = const Color(0xFF0047AB);

TextStyle appbarTitle = const TextStyle(
  color: Colors.white,
);

TextStyle cardDesc = TextStyle(
  color: blue,
  fontWeight: FontWeight.w600,
);

TextStyle info = TextStyle(
  color: Colors.grey[800],
);

TextStyle criarProduto = TextStyle(
  fontSize: 24,
  color: Colors.grey[300],
);

ButtonStyle dpvSelectedStyle = ElevatedButton.styleFrom(
  side: BorderSide(
    color: blue,
  ),
);

InputDecoration search = InputDecoration(
  labelText: "Pesquisar",
  helperText: "Digite o nome do produto",
  floatingLabelStyle: TextStyle(
    color: blue,
  ),
  contentPadding: const EdgeInsets.only(left: 10.0),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: blue),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: blue),
  ),
);

InputDecoration createDecor(String label) {
  return InputDecoration(labelText: label);
}
