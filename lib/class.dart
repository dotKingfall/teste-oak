class Produto{
  Produto({
    required this.id,
    required this.nome,
    required this.desc,
    required this.prec,
    required this.dpv,
});
  int id;
  String nome;
  String desc; //Descrição
  double prec; //Valor, preço
  bool dpv;    //Disponível para venda
}