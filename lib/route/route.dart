import 'package:flutter/material.dart';

import '../views/item/item_page.dart';

// Animação de transição para a tela dos itens
Route routePageItem(Map<String, dynamic> item) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        ItemPage(item: item),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0, 1);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 1000),
  );
}
