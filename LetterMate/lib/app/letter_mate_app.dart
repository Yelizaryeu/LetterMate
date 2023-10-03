import 'package:core/di/app_di.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

class LetterMateApp extends StatelessWidget {
  const LetterMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      //localizationsDelegates: context.localizationDelegates,
      //supportedLocales: context.supportedLocales,
      routerDelegate: appLocator.get<AppRouter>().delegate(),
      //theme: ThemeData(),
      routeInformationParser: appLocator.get<AppRouter>().defaultRouteParser(),
    );
  }
}
