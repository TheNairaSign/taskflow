import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flow/providers/auth_provider.dart';
import 'package:task_flow/providers/task_provider.dart';
import 'package:task_flow/screens/dashboard_screen.dart';
import 'package:task_flow/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    final darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212),
      primaryColor: const Color(0xFF3D7BFF),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF3D7BFF),
        secondary: Color(0xFF3D7BFF),
        background: Color(0xFF121212),
        surface: Color(0xFF1E1E1E),
      ),
    );

    final lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: const Color(0xFF3D7BFF),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.light().textTheme,
      ),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF3D7BFF),
        secondary: Color(0xFF3D7BFF),
        background: Colors.white,
        surface: Color(0xFFF0F0F0),
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(sharedPreferences)),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TaskFlow',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            home: auth.isAuthenticated
                ? const DashboardScreen()
                : const LoginScreen(),
            routes: {
              '/login': (context) => const LoginScreen(),
            },
          );
        },
      ),
    );
  }
}
