import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constant/constant.dart';
import '../models/person.dart';

class UserController extends GetxController {
  RxBool processing = false.obs;

  void changeStatus() {
    processing.toggle();
  }

  Future<Map> getAddress(String cep) async {
    http.Response response;

    response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

    return json.decode(response.body);
  }

  Future<int> userRegistration(Person person) async {
    final email = person.email.value;
    final name = person.name.value;
    final password = person.password.value;
    final cpf = person.cpf.value;
    final tel = person.tel.value;

    person.reset();

    http.Response response;

    Map<String, String> body = {
      "email": email,
      "password": password,
      "name": name!,
      "cpf": cpf,
      "tel": tel
    };

    response = await http.post(
        Uri.parse("https://parseapi.back4app.com/parse/functions/create-user"),
        headers: header,
        body: jsonEncode(body));
    //await Future.delayed(const Duration(seconds: 2));
    var resp = json.decode(response.body);
    if (response.statusCode == 200) {
      person = Person.fromjson(
          name: resp['result']['name'],
          cpf: cpf,
          email: resp['result']['email'],
          tel: tel,
          id: resp['result']['objectId'],
          session: resp['result']['sessionToken']);

      changeStatus();
      print(resp);
      return 200;
    } else {
      changeStatus();
      print(resp);
      return response.statusCode;
    }
  }

  Future<int> login(String emailData, String passwordData) async {
    http.Response response;
    final email = emailData;
    final password = passwordData;

    Map<String, String> body = {"email": email, "password": password};

    response = await http.post(
        Uri.parse("https://parseapi.back4app.com/parse/functions/login"),
        headers: header,
        body: jsonEncode(body));
    //await Future.delayed(const Duration(seconds: 5));
    var resp = json.decode(response.body);
    if (response.statusCode == 200) {
      String? cpf;
      String? tel;
      if (resp['result']['cpf'] != null) {
        cpf = resp['result']['cpf'];
      }
      if (resp['result']['tel'] != null) {
        tel = resp['result']['tel'];
      }

      Person person = Person.fromjson(
          name: resp['result']['name'],
          cpf: cpf,
          email: resp['result']['email'],
          tel: tel,
          id: resp['result']['id'],
          session: resp['result']['session']);
      changeStatus();
      //
      print(resp);
    } else {
      print(resp);
    }
    return response.statusCode;
  }
}
