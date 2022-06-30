import 'package:delivery_app_multi/pages/checkout_page.dart';
import 'package:delivery_app_multi/pages/login/SignUp_Pages/address_page.dart';
import 'package:delivery_app_multi/pages/login/SignUp_Pages/email_page.dart';
import 'package:delivery_app_multi/pages/login/SignUp_Pages/userdata_page.dart';
import 'package:delivery_app_multi/pages/login/signin_page.dart';
import 'package:delivery_app_multi/pages/profile_page.dart';
import 'package:delivery_app_multi/pages/root_page.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'back4app/credentials.dart';
import 'pages/login/SignUp_Pages/userdata_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /*final keyApplicationId = '7CL23wlKcmRh61hQN1OXNfKpY8YGFXOeQAOBhSH9';
  final keyClientKey = 'HibGluMR6cCCtuPnHDdbUuMfj4ygQHxNP16nvwrx';
  final keyParseServerUrl = 'https://parseapi.back4app.com';*/

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  print(DateTime.now());
  print('Sucesso ao inicializar');

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
