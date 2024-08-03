import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woutickpass/providers/token_provider.dart';
import 'package:woutickpass/screens/Tabs/main_nav.dart';
import 'package:woutickpass/screens/home_screen.dart';
import 'package:woutickpass/screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TokenProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WoutickPass',
        theme: ThemeData(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (context) => LoginScreen());
            case '/home':
              return MaterialPageRoute(builder: (context) => HomeScreen());
            case '/main':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) => MainPage(
                  token: args['token'],
                  currentIndex: args['currentIndex'],
                  selectedEvents: args['selectedEvents'],
                ),
              );
            default:
              return MaterialPageRoute(builder: (context) => SplashScreen());
          }
        },
        initialRoute: '/splash',
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _simulateStartup();
  }

  Future<void> _simulateStartup() async {
    await Future.delayed(Duration(seconds: 2));
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    final token = tokenProvider.token;

    if (token.isEmpty) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed(
        '/main',
        arguments: {
          'token': token,
          'currentIndex': 1,
          'selectedEvents': tokenProvider.selectedEvents,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
