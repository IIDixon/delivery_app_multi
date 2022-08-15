import 'dart:convert';

import 'package:delivery_app_multi/constant/constant.dart';
import 'package:delivery_app_multi/views/checkout/checkout_page.dart';
import 'package:delivery_app_multi/views/initial/cart_page.dart';
import 'package:delivery_app_multi/views/initial/profile_page.dart';
import 'package:delivery_app_multi/views/initial/root_page.dart';
import 'package:delivery_app_multi/views/initial/search_page.dart';
import 'package:delivery_app_multi/views/login/SignUp_Pages/address_page.dart';
import 'package:delivery_app_multi/views/login/SignUp_Pages/email_page.dart';
import 'package:delivery_app_multi/views/login/SignUp_Pages/userdata_page.dart';
import 'package:delivery_app_multi/views/login/signin_page.dart';
import 'package:delivery_app_multi/views/profile/orders.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'back4app/credentials.dart';
import 'models/loja.dart';
import 'views/login/SignUp_Pages/userdata_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]); // Função para bloquear rotação

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery App',
      home: const Splash(),
      routes: {
        '/root': (context) => const RootPage(),
        '/signin': (context) => const SigninPage(),
        '/signup/userdata': (context) => const SignupUserData(),
        '/signup/addressdata': (context) => const SignupAddressPage(),
        '/signup/emaildata': (context) => const SignupEmailPage(),
        '/profile': (context) => const ProfilePage(),
        '/profile/orders': (context) => const MyOrdersPage(),
        '/cart': (context) => const CartPage(),
        '/checkout': (context) => const CheckoutPage(),
        '/search': (context) => SearchPage()
      },
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Loja loja = Get.put(Loja());

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: const Image(
        image: AssetImage('assets/logo-multidrogas-big2.png'),
      ),
      logoSize: 200,
      backgroundColor: Colors.white,
      showLoader: true,
      loadingText: Text('Carregando dados...',
          style: TextStyle(color: Colors.blue[900], fontSize: 20)),
      futureNavigator: getLojas(),
    );
  }

  Future<Widget> getLojas() async {
    http.Response response = await http.post(
        Uri.parse("https://parseapi.back4app.com/parse/functions/get-lojas"),
        headers: header);

    Map orders = jsonDecode(response.body);

    for (int i = 0; i < orders['result'].length; i++) {
      lojas.add(orders['result'][i]);
    }

    return const RootPage();
  }
}
