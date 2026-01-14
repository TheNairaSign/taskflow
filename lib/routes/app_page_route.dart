import 'package:flutter/material.dart';

class AppPageRoute<T> extends PageRouteBuilder<T> {
  AppPageRoute({required WidgetBuilder builder})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionDuration: const Duration(milliseconds: 280),
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            final slideTween = Tween<Offset>(
              begin: const Offset(0, 0.1),
              end: Offset.zero,
            ).chain(
              CurveTween(curve: Curves.easeOutCubic),
            );

            final fadeTween = Tween<double>(
              begin: 0,
              end: 1,
            ).chain(
              CurveTween(curve: Curves.easeInOut),
            );

            return FadeTransition(
              opacity: animation.drive(fadeTween),
              child: SlideTransition(
                position: animation.drive(slideTween),
                child: child,
              ),
            );
          },
        );
}

