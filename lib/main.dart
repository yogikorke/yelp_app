import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yelp_app/bloc/businesses/businesses_bloc.dart';
import 'package:yelp_app/ui/businesses/businesses_list_page.dart';
import 'package:yelp_app/values/app_themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Add this line
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2280),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocProvider(
          create: (context) => BusinessesBloc(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Yelp App',
            theme: AppTheme.getLightThemeData(Brightness.light),
            localizationsDelegates: const [
              AppLocalizations.delegate, // Add this line
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('es'), // Spanish
            ],
            home: const BusinessesPage(),
          ),
        );
      },
    );
  }
}
