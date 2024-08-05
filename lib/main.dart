import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woutickpass/providers/token_provider.dart';
import 'package:woutickpass/screens/Tabs/main_nav.dart';
import 'package:woutickpass/screens/Home_screen.dart';
import 'package:woutickpass/screens/Login_screen.dart';

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
              return MaterialPageRoute(builder: (context) => HomeScreen());
            case '/home':
              return MaterialPageRoute(builder: (context) => LoginScreen());
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
              return MaterialPageRoute(builder: (context) => LoginScreen());
          }
        },
        initialRoute: '/login',
      ),
    );
  }
}
