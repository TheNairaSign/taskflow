import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/providers/auth_provider.dart';
import 'package:task_flow/routes/app_page_route.dart';
import 'package:task_flow/screens/dashboard_screen.dart';
import 'package:task_flow/screens/login_screen.dart';
import 'package:animate_do/animate_do.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3)); // Increased duration
    if (!mounted) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.isAuthenticated) {
      Navigator.of(context).pushReplacement(
        AppPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        AppPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeIn(
              duration: const Duration(seconds: 2),
              child: Icon(
                EvaIcons.checkmarkSquare2Outline,
                size: 50,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 10),
            SlideInRight(
              duration: const Duration(milliseconds: 1500),
              from: 100,
              child: Text(
                'TaskFlow',
                style: GoogleFonts.inter(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
