import 'package:get/get.dart';

class Loja extends GetxController {
  static final Loja loja = Loja._internal();

  factory Loja() {
    return loja;
  }

  factory Loja.fromJson(String id, String razao, String fantasia, String cidade,
      String rua, String bairro, String numero, double lat, double long) {
    loja.id.value = id;
    loja.razaoSocial.value = razao;
    loja.nomeFantasia.value = fantasia;
    loja.rua.value = rua;
    loja.bairro.value = bairro;
    loja.number.value = numero;
    loja.cidade.value = cidade;
    loja.lat.value = lat.toString();
    loja.long.value = long.toString();

    return loja;
  }

  void reset() {
    id = ''.obs;
    razaoSocial = ''.obs;
    nomeFantasia = ''.obs;
    cidade = ''.obs;
    rua = ''.obs;
    bairro = ''.obs;
    number = ''.obs;
  }

  Loja._internal();

  late var id = ''.obs;
  late var razaoSocial = ''.obs;
  late var nomeFantasia = ''.obs;
  late var cidade = ''.obs;
  late var rua = ''.obs;
  late var bairro = ''.obs;
  late var number = ''.obs;
  late var lat = ''.obs;
  late var long = ''.obs;
}
