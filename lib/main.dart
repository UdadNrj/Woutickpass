import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woutickpass/providers/token_login.dart';
import 'package:woutickpass/screens/Tabs/main_nav.dart';
import 'package:woutickpass/screens/home_screen.dart';

// import 'src/app.dart';
// import 'src/settings/settings_controller.dart';
// import 'src/settings/settings_service.dart';

// void main() async {
//   // Set up the SettingsController, which will glue user settings to multiple
//   // Flutter Widgets.
//   final settingsController = SettingsController(SettingsService());

//   // Load the user's preferred theme while the splash screen is displayed.
//   // This prevents a sudden theme change when the app is first displayed.
//   await settingsController.loadSettings();

//   // Run the app and pass in the SettingsController. The app listens to the
//   // SettingsController for changes, then passes it further down to the
//   // SettingsView.
//   runApp(MyApp(settingsController: settingsController));

void main() {
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
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Consumer<TokenProvider>(
                builder: (context, tokenProvider, _) {
                  if (tokenProvider.token.isEmpty) {
                    return HomeScreen();
                  } else {
                    return MainPage(
                      token: tokenProvider.token,
                      currentIndex: 1,
                      selectedEvents: [],
                    );
                  }
                },
              ),
        },
      ),
    );
  }
}


//Progresss mientras eduardo me envia endpoints

// import 'package:provider/provider.dart';
// import 'package:woutickpass/providers/token_login.dart';
// import 'package:woutickpass/screens/login_screen.dart';

// import 'package:woutickpass/models/Custom_Session.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => TokenProvider()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'WoutickPass',
//         initialRoute: '/',
//         onGenerateRoute: (settings) {
//           if (settings.name == '/') {
//             // Define the initial parameters here
//             final int initialIndex = 0;
//             final List<SessionOn> initialSelectedSessions = [];

//             return MaterialPageRoute(
//               builder: (context) => MainPage(
//                 currentIndex: initialIndex,
//                 selectedSessions: initialSelectedSessions,
//               ),
//             );
//           } else if (settings.name == '/login') {
//             return MaterialPageRoute(builder: (context) => LoginPage());
//           }
//           // Handle other routes if necessary
//           return null;
//         },
//       ),
//     );
//   }
// }
