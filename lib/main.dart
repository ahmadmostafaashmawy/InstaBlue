import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:insta_blue/utilities/localization/app_localizations.dart';
import 'package:insta_blue/utilities/routes.dart';
import 'bloc/lang/lang_bloc.dart';
import 'bloc/lang/lang_state.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    /// Language Change Bloc
    BlocProvider<LanguageBloc>(create: (context) => LanguageBloc()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  static String lang = 'ar';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
      LanguageBloc languageBloc = BlocProvider.of(context);
      MyApp.lang = languageBloc.lang;

      return ScreenUtilInit(
        designSize: Size(392.0, 759.272727),
        allowFontScaling: false,
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: routes,
          supportedLocales: [
            Locale('ar', 'EG'),
            Locale('en', 'US'),
          ],
          locale: Locale(MyApp.lang),
          localizationsDelegates: [
            // THIS CLASS WILL BE ADDED LATER
            // A class which loads the translations from JSON files
            AppLocalizations.delegate,
            // Built-in localization of basic text for Material widgets
            GlobalMaterialLocalizations.delegate,
            // Built-in localization for text direction LTR/RTL
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate
          ],
        ),
      );
    });
  }
}
