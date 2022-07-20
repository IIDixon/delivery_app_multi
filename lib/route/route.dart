import 'package:flutter/material.dart';

import '../views/item_page.dart';

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
