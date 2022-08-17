import 'dart:core';

import 'package:intl/intl.dart';

class Item {
  Item();

  Item.fromJson({this.qtde, required Map<String, dynamic> json}) {
    id = json['codigo'];
    name = json['description'];
    value = double.parse(NumberFormat('###.0#', 'en_US').format(json['pmc']));
    valueSale =
        double.parse(NumberFormat('###.0#', 'en_US').format(json['venda']));
    categoria = json['categoria'];
    imgUrl = json['imgUrl'];
    laboratorio = json['laboratorio'];
  }

  late String id;
  late String name;
  late double value;
  late double valueSale;
  late String categoria;
  late String imgUrl;
  late String laboratorio;
  int? qtde;
}
