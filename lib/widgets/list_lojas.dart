import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../models/loja.dart';

Widget ListLojas(BuildContext context) {
  Loja loja = Get.put(Loja());

  return ListView.builder(
    itemCount: lojas.length,
    itemBuilder: (context, index) {
      return Card(
        elevation: 3,
        child: ListTile(
          onTap: () {},
          title: Text(
            lojas[0]['fantasia'],
            style: const TextStyle(fontSize: 20),
          ),
          subtitle: Text(
            lojas[index]['rua'] +
                ', ' +
                lojas[index]['numero'] +
                ', ' +
                lojas[index]['bairro'] +
                ' - ' +
                lojas[index]['cidade'],
            style: const TextStyle(fontSize: 17),
          ),
        ),
      );
    },
  );
}
