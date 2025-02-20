import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threethings/providers/theme_provider.dart';
import 'package:threethings/screens/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: SplashScreen(),
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'presentation/layouts/main_layout.dart';
// import 'presentation/screens/auth/sign_in_screen.dart';
// import 'presentation/screens/auth/sign_up_screen.dart';
// import 'presentation/screens/profile/profile_screen.dart';
// import 'presentation/screens/settings/settings_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       initialRoute: '/sign-in',
//       routes: {
//         '/sign-in': (context) => SignInScreen(),
//         '/sign-up': (context) => SignUpScreen(),
//         '/main': (context) => MainLayout(),
//         '/profile': (context) => ProfileScreen(),
//         '/settings': (context) => SettingsScreen(),
//       },
//     );
//   }
// }

