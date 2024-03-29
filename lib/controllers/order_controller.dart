import 'dart:convert';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constant/constant.dart';
import '../models/cart.dart';
import '../models/item.dart';
import '../models/person.dart';

class OrderController extends GetxController {
  RxBool processing = false.obs;

  Cart cart = Get.put(Cart());
  Person person = Get.put(Person());

  void changeStatus() {
    processing.toggle();
  }

  String toJson(Person person, List<Item> itens, String tpp) {
    var order = <dynamic, dynamic>{};
    var num = Random();
    double value = 5; // 5 para embutir já o frete, apenas demonstrativo
    DateTime data = DateTime.now();
    DateFormat('dd/MM/yyyy')
        .format(data); // Formata a data em um padrão específico

    for (int i = 0; i < listItem(itens).length; i++) {
      //Calcula o valor total dos itens
      value += listItem(itens)[i]['totalValue'];
    }
    order['numeroVenda'] = num.nextInt(99999);
    order['userid'] = person.id.value;
    order['loja'] = 'jEve0fFXw4';
    order['date'] = data.toIso8601String();
    order['value'] = value;
    order['itens'] = listItem(itens);
    order['tpp'] = tpp;
    order['status'] = 'Entregue';

    return jsonEncode(order);
  }

  List<Map> listItem(List<Item> itens) {
    List<Map> list = [];

    for (int i = 0; i < itens.length; i++) {
      Map map = {};
      map['product'] =
          'bOtGaEgQyz' /*itens[i].id *ALTERAR PARA O ID DO PRODUTO*/;
      map['qtde'] = itens[i].qtde;
      map['unitValue'] = itens[i].valueSale;
      map['totalValue'] = (itens[i].qtde! * itens[i].valueSale);
      list.add(map);
    }

    return list;
  }

  Future<http.Response> postOrder(dynamic order) async {
    Map<String, String> headers = header;
    headers.addAll({"X-Parse-Session-Token": person.session.value});

    http.Response response = await http.post(
        Uri.parse("https://parseapi.back4app.com/parse/functions/create-sale"),
        headers: headers,
        body: order);

    var resp = json.decode(response.body);
    print('Resposta do retorno: ${response.statusCode}');
    print(resp);
    if (response.statusCode == 200) {
      cart.items.clear();
    }
    await Future.delayed(const Duration(seconds: 2));

    changeStatus();

    return response;
  }

  Future<List<Map>> getOrders() async {
    Map body = {'userid': person.id.value};
    Map<String, String> headers = header;
    headers.addAll({"X-Parse-Session-Token": person.session.value});

    http.Response response = await http.post(
        Uri.parse(
            "https://parseapi.back4app.com/parse/functions/get-salesUser"),
        headers: headers,
        body: jsonEncode(body));

    var resp = json.decode(response.body);
    Map orders = jsonDecode(response.body);
    List<Map> list = [];

    for (int i = 0; i < orders['result'].length; i++) {
      list.add(orders['result'][i]);
    }
    print('Resultado - $list - ${list.length}');
    return list;
  }

  Future<List<Map>> getItens(String sale) async {
    Map body = {'id': sale};
    Map<String, String> headers = header;
    headers.addAll({"X-Parse-Session-Token": person.session.value});

    http.Response response = await http.post(
        Uri.parse(
            "https://parseapi.back4app.com/parse/functions/get-saleitens"),
        headers: headers,
        body: jsonEncode(body));

    Map itens = jsonDecode(response.body);
    List<Map> listItens = [];

    for (int i = 0; i < itens['result'].length; i++) {
      listItens.add(itens['result'][i]);
    }
    print(listItens);
    return listItens;
  }

  Future<double> calcFrete(
      double startLat, double startLong, double endLat, double endLong) async {
    return Geolocator.distanceBetween(startLat, startLong, endLat, endLong);

    // API para buscar latitude e longitude pelo endereço
    //https://nominatim.openstreetmap.org/?addressdetails=1&q=nelvo+facchini+271&format=json&limit=1
  }
}
