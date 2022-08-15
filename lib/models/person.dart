import 'package:get/get.dart';

import 'address.dart';

class Person extends GetxController {
  static final Person person = Person._internal();

  factory Person() {
    return person;
  }

  factory Person.fromjson(
      {String? name,
      String? cpf,
      String? email,
      String? tel,
      String? id,
      String? session}) {
    person.name.value = name!.capitalizeFirst;
    if (cpf != null) {
      person.cpf.value = cpf;
    }
    person.email.value = email!;
    if (tel != null) {
      person.tel.value = tel;
    }
    person.session.value = session!;
    if (id != null) {
      person.id.value = id;
    }
    return person;
  }

  Person._internal();

  late var name = ''.capitalizeFirst.obs;
  late var cpf = ''.obs;
  late var email = ''.obs;
  late var password = ''.obs;
  late var tel = ''.obs;
  late var id = ''.obs;
  late var session = ''.obs;
  //late Address address;

  void reset() {
    name = ''.obs;
    cpf = ''.obs;
    email = ''.obs;
    password = ''.obs;
    tel = ''.obs;
    id = ''.obs;
    session = ''.obs;
  }
}
