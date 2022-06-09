import 'package:get/get.dart';

class Person extends GetxController {
  static final Person person = Person._internal();

  factory Person() {
    return person;
  }

  factory Person.fromjson(
      {String? name, String? cpf, String? email, String? tel}) {
    person.name.value = name!;
    person.cpf.value = cpf!;
    person.email.value = email!;
    person.tel.value = tel!;
    return person;
  }

  Person._internal();

  late var name = ''.obs;
  late var cpf = ''.obs;
  late var email = ''.obs;
  late var password = ''.obs;
  late var tel = ''.obs;

  void reset() {
    name = ''.obs;
    cpf = ''.obs;
    email = ''.obs;
    password = ''.obs;
    tel = ''.obs;
  }
}
