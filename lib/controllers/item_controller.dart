import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../constant/constant.dart';

class ItemController extends GetxController {
  void addList(List<Map<String, dynamic>> listItems) {
    searchItems.clear();
    for (int i = 0; i < listItems.length; i++) {
      searchItems.add(listItems[i]);
    }
  }

  void searchItemsBD(String name) async {
    Map<String, String> headers = header;
    Map body = {'name': name};

    http.Response response = await http.post(
        Uri.parse('https://parseapi.back4app.com/parse/functions/get-product'),
        headers: headers,
        body: jsonEncode(body));

    print('Itens encontrados - ${jsonDecode(response.body)['result']}');
    List<Map<String, dynamic>> list = [];
    Map items = jsonDecode(response.body);
    for (int i = 0; i < items['result'].length; i++) {
      list.add(items['result'][i]);
    }
    addList(list);
  }
}
