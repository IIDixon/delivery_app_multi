import 'dart:core';

class Item{

  Item({required this.name, required this.value, required this.valueSale, required this.qtde, required this.categoria, required this.laboratorio, required this.imgUrl});

  Item.fromJson({required Map<String, dynamic> json, required this.qtde}) : name = json['description'],
    value = double.parse(json['pmc']), valueSale = double.parse(json['venda']), categoria = json['categoria'], imgUrl = json['imgUrl'], laboratorio = json['laboratorio'];

  String name;
  double value;
  double valueSale;
  int qtde;
  String categoria;
  String imgUrl;
  String laboratorio;
}