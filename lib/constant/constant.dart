import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../back4app/credentials.dart';

const List<IconData> icons = [
  Icons.home,
  Icons.search,
  Icons.shopping_cart_outlined,
  Icons.person_outline
];

Map<String, dynamic> profile = {
  'name': 'Nathan',
  'CPF': '123.456.789-00',
  'email': 'nathan@gmail.com',
  'cel': '(11) 91234-5678',
  'address': {
    'street': 'Rua do asfalto',
    'number': '7070',
    'district': 'Vila das casas',
    'city': 'São Paulo do Rio Pardo',
    'CEP': '15069-069'
  },
};

Map<String, String> header = {
  "X-Parse-Application-Id": keyApplicationId,
  "X-Parse-REST-API-Key": restApiKey,
  "Content-Type": "application/json"
};

List<Map> lojas = [];

List<Map<dynamic, dynamic>> orders = [];

List<Map<String, dynamic>> items = [
  {
    'description': 'Dorflex 12 Comp.',
    'qtde': '10',
    'pmc': 20.00,
    'venda': 10.50,
    'desconto': 9.50,
    'laboratorio': 'Catarinense',
    'categoria': 'Vitaminas',
    'imgUrl':
        'https://parsefiles.back4app.com/7CL23wlKcmRh61hQN1OXNfKpY8YGFXOeQAOBhSH9/00069c2c3dae97627ccad137e64181aa_img%20padrao.png'
  },
  {
    'description': 'Anador 500MG 24CP',
    'qtde': '5',
    'pmc': 25.00,
    'venda': 16.00,
    'desconto': 9.00,
    'laboratorio': 'Catarinense',
    'categoria': 'Vitaminas',
    'imgUrl':
        'https://parsefiles.back4app.com/7CL23wlKcmRh61hQN1OXNfKpY8YGFXOeQAOBhSH9/00069c2c3dae97627ccad137e64181aa_img%20padrao.png'
  },
  {
    'description': 'Dipirona Sódica 1MG 30CP',
    'qtde': '10',
    'pmc': 18.00,
    'venda': 8.50,
    'desconto': 9.50,
    'laboratorio': 'Catarinense',
    'categoria': 'Vitaminas',
    'imgUrl':
        'https://parsefiles.back4app.com/7CL23wlKcmRh61hQN1OXNfKpY8YGFXOeQAOBhSH9/00069c2c3dae97627ccad137e64181aa_img%20padrao.png'
  },
  {
    'description': 'Dipirona Sódica 500MG 30CP',
    'qtde': '10',
    'pmc': 15.00,
    'venda': 5.50,
    'desconto': 9.50,
    'laboratorio': 'Catarinense',
    'categoria': 'Vitaminas',
    'imgUrl':
        'https://parsefiles.back4app.com/7CL23wlKcmRh61hQN1OXNfKpY8YGFXOeQAOBhSH9/00069c2c3dae97627ccad137e64181aa_img%20padrao.png'
  },
  {
    'description': 'Dorflex Uno 10CP',
    'qtde': '50',
    'pmc': 20.00,
    'venda': 16.50,
    'desconto': 3.50,
    'laboratorio': 'Catarinense',
    'categoria': 'Vitaminas',
    'imgUrl':
        'https://parsefiles.back4app.com/7CL23wlKcmRh61hQN1OXNfKpY8YGFXOeQAOBhSH9/00069c2c3dae97627ccad137e64181aa_img%20padrao.png'
  },
  {
    'description': 'Lisador Dip 1G 20CP',
    'qtde': '20',
    'pmc': 35.00,
    'venda': 22.80,
    'desconto': 12.20,
    'laboratorio': 'Catarinense',
    'categoria': 'Vitaminas',
    'imgUrl':
        'https://parsefiles.back4app.com/7CL23wlKcmRh61hQN1OXNfKpY8YGFXOeQAOBhSH9/00069c2c3dae97627ccad137e64181aa_img%20padrao.png'
  },
];

List<Map<String, dynamic>> dorDeCabeca = [
  {
    'description': 'Lisador Dip 1G',
    'unit': 10,
    'pmc': 20.00,
    'venda': 10.50,
    'desconto': 9.50,
  },
  {
    'description': 'Alivium 400MG 3 Caps.',
    'unit': 20,
    'pmc': 8.00,
    'venda': 1.69,
    'desconto': 9.50,
  },
  {
    'description': 'Neosaldina 30 Drágeas',
    'unit': 10,
    'pmc': 36.00,
    'venda': 24.87,
    'desconto': 9.50,
  },
  {
    'description': 'Dorilen 12 Comp.',
    'unit': 10,
    'pmc': 16.00,
    'venda': 7.08,
    'desconto': 9.50,
  },
  {
    'description': 'Clor. Naratriptana 10 Comp.',
    'unit': 10,
    'pmc': 32.80,
    'venda': 20.50,
    'desconto': 9.50,
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
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'pmc': 121.24,
    'venda': 101.30,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2020/05/7896023728761_Up-Vitam-Artro-Colag-tipo-II-UCII-30-cps-430-x-321_.jpg'
  },
  {
    'description': 'Cabelos e Unhas 60CAPS',
    'pmc': 58.96,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 48.90,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023702440_Up-Vitam-Cabelos-e-Unhas-60-cps-430-x-321_.jpg'
  },
  {
    'description': 'Cafeína 60Caps',
    'pmc': 58.04,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 49.90,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023720871_Up-Vitam-Cafeina-60-cps-430-x-321_.jpg'
  },
  {
    'description': 'Calcio 600+D3+K2 60Cp',
    'pmc': 39.04,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 30.00,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023716973_Up-Vitam-Calcio-600-DK-60-cpr-430-x-321_.jpg'
  },
  {
    'description': 'Calcio MDK 60Caps',
    'pmc': 41.32,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 33.80,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2021/06/up-vitam-calcio-mdk.jpg'
  },
  {
    'description': 'Clor. Magnésio 1700MG 60Cp',
    'pmc': 38.65,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 30.10,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023708893_Up-Vitam-Cloreto-de-Magnesio-60-cpr-430-x-321_.jpg'
  },
  {
    'description': 'Colágeno Hidrolisado 50Caps',
    'pmc': 53.88,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 46.00,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023701078_Up-Vitam-Colageno-Hidrolisado-50-cps-430-x-321_.jpg'
  },
  {
    'description': 'Complexo B 60Caps',
    'pmc': 55.79,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 48.20,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023720864_Up-Vitam-Complexo-B-60-cps-430-x-321_.jpg'
  },
  {
    'description': 'Up Vitam Energia 60Caps',
    'pmc': 51.60,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 39.10,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2020/05/7896023722189_Up-Vitam-Energia-60-cps-430-x-321_.jpg'
  },
  {
    'description': 'Up Vitam Homem 60Caps',
    'pmc': 47.90,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 38.80,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023706080_Up-Vitam-Homem-60-cps-430-x-321_.jpg'
  },
  {
    'description': 'Up Vitam Imunidade 60Caps',
    'pmc': 52.21,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 39.90,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2020/05/7896023722356_Up-Vitam-Imunidade-60-cps-430-x-321_.jpg'
  },
  {
    'description': 'Polivitamínico Kids 30 Gomas',
    'pmc': 31.17,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 24.60,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2021/01/UP-VITAM-KIDS-1024x833.png'
  },
  {
    'description': 'Kit Omega 3 300Caps',
    'pmc': 130.42,
    'laboratorio': 'Catarinense',
    'qtde': '300',
    'categoria': 'Vitaminas',
    'venda': 125.20,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2020/05/7896023720833_Up-Vitam-Kit-Omega-300-cps-430-x-321_.jpg'
  },
  {
    'description': 'Up Vitam Mulher 60Caps',
    'pmc': 47.90,
    'laboratorio': 'Catarinense',
    'qtde': '60',
    'categoria': 'Vitaminas',
    'venda': 36.20,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023703614_Up-Vitam-Mulher-60-cps-430-x-321_.jpg'
  },
  {
    'description': 'Óleo de Alho Desodorizado 60Caps',
    'pmc': 38.66,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 29.60,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023720888_Up-Vitam-Oleo-de-Alho-Desodorizado-60-cps-430-x-321_.jpg'
  },
  {
    'description': 'Óleo de Côco 60Caps',
    'pmc': 84.82,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 71.60,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023700293_Up-Vitam-Oleo-de-Coco-1000mg-60-cps-430-x-321_.jpg'
  },
  {
    'description': 'Óleo de Linhaça 30Caps',
    'pmc': 45.24,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 35.60,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023701092_Up-Vitam-Oleo-de-Linhaca-30-cps-430-x-321_.jpg'
  },
  {
    'description': 'Ômega 3 60Caps',
    'pmc': 42.31,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 33.60,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023702105_Up-VITAM-Omega-3-1000-mg-60-cps-430-x-321_.jpg'
  },
  {
    'description': 'Ômega 3 120Caps',
    'pmc': 81.66,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 60.09,
    'imgUrl': 'https://www.upvitam.com.br/wp-content/uploads/2020/01/omega3.jpg'
  },
  {
    'description': 'Picolinato de Cromo 60Caps',
    'pmc': 65.03,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 53.55,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023701085_Up-Vitam-Picolinato-de-Cromo-60-cps-430-x-321_.jpg'
  },
  {
    'description': 'Polivitamínico 50+ 60Caps',
    'pmc': 47.90,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 36.90,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023706110_Up-Vitam-Senior-60-cps-430-x-321_.jpg'
  },
  {
    'description': 'Polivitamínico 60Caps',
    'pmc': 47.90,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 37.90,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023700507_Up-Vitam-Polivitaminico-A-Z-60-cps-430-x-321_.jpg'
  },
  {
    'description': 'Própolis 30Caps',
    'pmc': 44.21,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 36.40,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2021/01/PACK-UP-VITAM-PROPOLIS-1024x819.png'
  },
  {
    'description': 'Termobio 60Caps',
    'pmc': 55.68,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 48.50,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2020/05/7896023721175_Up-Vitam-Termobio-60-cps-430-x-321_.jpg'
  },
  {
    'description': 'Triplo Imuno 30Caps',
    'pmc': 54.58,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 47.20,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2021/01/UP-VITAM-TRIPLO-IMUNO-1024x819.png'
  },
  {
    'description': 'Triptofano 860MG 60Caps',
    'pmc': 69.38,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 52.90,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2020/05/7896023722134_Up-Vitam-Triptofano-60-cps-430-x-321_.jpg'
  },
  {
    'description': 'Up Vitam Cartamus 90Caps',
    'pmc': 157.82,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 130.22,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2021/01/UP-VITAM-CARTAMUS-739x1024.png'
  },
  {
    'description': 'Vitamina C 1000UI 30Cp',
    'pmc': 51.65,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 39.80,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2020/05/7896023729287_Up-Vitam-Vitamina-C-1000-mg-30-cpr-430-x-321_.jpg'
  },
  {
    'description': 'Vitamina D 1000UI 30Caps',
    'pmc': 37.40,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 31.20,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023720895_Up-Vitam-Vitamina-D-1000-UI-30-cps-430-x-321_.jpg'
  },
  {
    'description': 'Vitamina D 2000UI 30Caps',
    'pmc': 49.91,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 39.90,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023720901_Up-Vitam-Vitamina-D-2000-UI-30-cps-430-x-321_.jpg'
  },
  {
    'description': 'Vitamina E 400UI 30Caps',
    'pmc': 46.66,
    'laboratorio': 'Catarinense',
    'qtde': '30',
    'categoria': 'Vitaminas',
    'venda': 39.90,
    'imgUrl':
        'https://www.upvitam.com.br/wp-content/uploads/2019/06/7896023720918_Up-Vitam-Vitamina-E-400-UI-30-cps-430-x-321_.jpg'
  },
];

List<Map<String, dynamic>> searchItems = <Map<String, dynamic>>[].obs;
