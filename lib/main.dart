import 'package:delivery_app_multi/pages/login/SignUp_Pages/address_page.dart';
import 'package:delivery_app_multi/pages/login/SignUp_Pages/email_page.dart';
import 'package:delivery_app_multi/pages/login/SignUp_Pages/userdata_page.dart';
import 'package:delivery_app_multi/pages/login/signin_page.dart';
import 'package:delivery_app_multi/pages/profile_page.dart';
import 'package:delivery_app_multi/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final keyApplicationId = '7CL23wlKcmRh61hQN1OXNfKpY8YGFXOeQAOBhSH9';
  final keyClientKey = 'HibGluMR6cCCtuPnHDdbUuMfj4ygQHxNP16nvwrx';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

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
      initialRoute: '/',
      routes: {
        '/': (context) => const RootPage(),
        '/signin': (context) => const SigninPage(),
        '/signup/userdata': (context) => const SignupUserData(),
        '/signup/addressdata' : (context) => const SignupAddressPage(),
        '/signup/emaildata' : (context) => const SignupEmailPage(),
        '/profile' : (context) => const ProfilePage(),
      },
    );
  }
}
