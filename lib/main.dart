import 'package:delivery_app_multi/pages/cart_page.dart';
import 'package:delivery_app_multi/pages/checkout_page.dart';
import 'package:delivery_app_multi/pages/login/SignUp_Pages/address_page.dart';
import 'package:delivery_app_multi/pages/login/SignUp_Pages/email_page.dart';
import 'package:delivery_app_multi/pages/login/SignUp_Pages/userdata_page.dart';
import 'package:delivery_app_multi/pages/login/signin_page.dart';
import 'package:delivery_app_multi/pages/profile/orders.dart';
import 'package:delivery_app_multi/pages/profile_page.dart';
import 'package:delivery_app_multi/pages/root_page.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'back4app/credentials.dart';
import 'pages/login/SignUp_Pages/userdata_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); // Função para bloquear rotação

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
        navigator: const RootPage(),
        durationInSeconds: 5);
  }
}
