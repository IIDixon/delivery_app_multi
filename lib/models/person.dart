import 'package:get/get.dart';

class Person extends GetxController {
  static final Person person = Person._internal();

  factory Person() {
    return person;
  }

  factory Person.fromjson(
      {String? name, String? cpf, String? email, String? tel, String? id}) {
    person.name.value = name!.capitalizeFirst;
    person.cpf.value = cpf!;
    person.email.value = email!;
    person.tel.value = tel!;
    if(id != null){
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

  void reset() {
    name = ''.obs;
    cpf = ''.obs;
    email = ''.obs;
    password = ''.obs;
    tel = ''.obs;
    id = ''.obs;
  }
}
