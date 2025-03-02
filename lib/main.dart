import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threethings/providers/theme_provider.dart';
import 'package:threethings/screens/auth/sign_in_screen.dart';
import 'package:threethings/screens/home_screen.dart';
import 'package:threethings/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyA2dOGYa4bud8BFsdgRZXi-6fEeHUyWRsY",
        authDomain: "three-things-todo.firebaseapp.com",
        projectId: "three-things-todo",
        storageBucket: "three-things-todo.firebasestorage.app",
        messagingSenderId: "984158775162",
        appId: "1:984158775162:web:4ab0898e889ab478f518c3",
        measurementId: "G-RF03EHP6EW",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    bool isSignedIn = false;

    @override
    void initState() {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          isSignedIn = true;
        }
      });
    }

    ;

    return MaterialApp(
      home: SplashScreen(
        isSignIn: isSignedIn,
      ),
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
