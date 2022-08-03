import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../models/loja.dart';

Widget ListLojas(BuildContext context) {
  Loja loja = Get.put(Loja());

  final ScrollController scrollController = ScrollController();

  return Container(
    height: MediaQuery.of(context).size.height * 0.6,
    width: MediaQuery.of(context).size.width,
    child: Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      trackVisibility: true,
      interactive: true,
      child: ListView.builder(
        controller: scrollController,
        itemCount: lojas.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  loja = Loja.fromJson(
                    lojas[index]['id'],
                    lojas[index]['razao'],
                    lojas[index]['fantasia'],
                    lojas[index]['cidade'],
                    lojas[index]['rua'],
                    lojas[index]['bairro'],
                    lojas[index]['numero'],
                    lojas[index]['geo']['latitude'],
                    lojas[index]['geo']['longitude'],
                  );
                },
                title: Text(
                  lojas[index]['fantasia'],
                  style: TextStyle(fontSize: 20, color: Colors.blue[900]),
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
                trailing: const Icon(
                  Icons.circle_rounded,
                  color: Colors.green,
                  size: 14,
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
