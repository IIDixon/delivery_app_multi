import 'package:flutter/material.dart';

const List<IconData> icons = [
  Icons.home,
  Icons.search,
  Icons.shopping_cart_outlined,
  Icons.person_outline
];

List<Map<String, dynamic>> items = [
  {
    'description': 'Dorflex 12 Comp.',
    'unit': 10,
    'pmc': '20.00',
    'venda': '10.50',
    'desconto': '9.50',
  },
  {
    'description': 'Anador 500MG 24CP',
    'unit': 5,
    'pmc': '25.00',
    'venda': '16.00',
    'desconto': '9.00',
  },
  {
    'description': 'Dipirona Sódica 1MG 30CP',
    'unit': 10,
    'pmc': '18.00',
    'venda': '8.50',
    'desconto': '9.50',
  },
  {
    'description': 'Dipirona Sódica 500MG 30CP',
    'unit': 10,
    'pmc': '15.00',
    'venda': '5.50',
    'desconto': '9.50',
  },
  {
    'description': 'Dorflex Uno 10CP',
    'unit': 50,
    'pmc': '20.00',
    'venda': '16.50',
    'desconto': '3.50',
  },
  {
    'description': 'Lisador Dip 1G 20CP',
    'unit': 20,
    'pmc': '35.00',
    'venda': '22.80',
    'desconto': '12.20',
  },
];

List<Map<String, dynamic>> dorDeCabeca = [
  {
    'description': 'Lisador Dip 1G',
    'unit': 10,
    'pmc': '20.00',
    'venda': '10.50',
    'desconto': '9.50',
  },
  {
    'description': 'Alivium 400MG 3 Caps.',
    'unit': 20,
    'pmc': '8.00',
    'venda': '1.69',
    'desconto': '9.50',
  },
  {
    'description': 'Neosaldina 30 Drágeas',
    'unit': 10,
    'pmc': '36.00',
    'venda': '24.87',
    'desconto': '9.50',
  },
  {
    'description': 'Dorilen 12 Comp.',
    'unit': 10,
    'pmc': '16.00',
    'venda': '7.08',
    'desconto': '9.50',
  },
  {
    'description': 'Clor. Naratriptana 10 Comp.',
    'unit': 10,
    'pmc': '32.80',
    'venda': '20.50',
    'desconto': '9.50',
  },
];

List<Map<String, dynamic>> categories = [
  {
    'title': 'Dor de Cabeça',
  },
  {
    'title': 'Anti-Inflamatórios',
  },
  {
    'title': 'Anti-Gripais',
  },
  {'title': 'Visão'},
  {'title': 'Vitaminas'},
  {'title': 'Perfumaria em Geral'},
  {'title': 'Equip. Ortopédicos'},
];

List<Map<String, dynamic>> sliderDescription = [
  {
    'title': 'Jornal de Ofertas',
    'description': 'Descontos exclusivos em uma grande variedade de produtos'
  },
  {
    'title': 'PBM Multidrogas',
    'description': 'Garanta descontos exclusivos em medicamentos'
  },
  {
    'title': 'Multifidelidade',
    'description': 'Acumule pontos e troque por descontos em suas compras'
  },
];

List<Image> slider = [
  Image.asset('assets/JORNAL.jpg'),
  Image.asset('assets/PBM.jpg'),
  Image.asset('assets/FIDELIDADE.jpg'),
];

List<Map<String, dynamic>> upvitam = [
  {
    'description': 'Colageno tipo II 40MG',
    'pmc': '45.90',
    'venda': '37.20',
    'imgUrl': Image.asset('assets/PBM.jpg')
  },
  {
    'description': 'Cabelos e Unhas 60CAPS',
    'pmc': '22.60',
    'venda': '16.50',
    'imgUrl': Image.asset('assets/PBM.jpg')
  },
  {
    'description': 'Cafeína 60Caps',
    'pmc': '45.90',
    'venda': '37.20',
    'imgUrl': Image.asset('assets/PBM.jpg')
  },
];
