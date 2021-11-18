import 'dart:io';
import 'dart:async';
import 'package:dmarketing/pages/signing/first_vistor.dart';
import 'package:dmarketing/pages/signing/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:dmarketing/app_config/providers.dart';
import 'package:dmarketing/helper/checkUser.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/pages/merchant/market_root_pages.dart';
import 'package:dmarketing/root_pages.dart';
import 'package:dmarketing/pages/signing/choose_register_kind.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GlobalConfiguration().loadFromAsset("configurations");
  await checkUser();
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en_US', supportedLocales: ['en_US', 'ar']);
  runApp(LocalizedApp(
      delegate,
      MyApp(
        check: "2",
      )));
}

class MyApp extends StatelessWidget {
  String check;
  MyApp({this.check});
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return MultiProvider(
      providers: ProvidersList.getProviders,
      child: LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'D marketing',
          theme: ThemeData(
            textTheme:
                GoogleFonts.latoTextTheme(Theme.of(context).textTheme).copyWith(
              body1: GoogleFonts.cairo(
                  textStyle: Theme.of(context).textTheme.body1,
                  fontWeight: FontWeight.bold),
            ),
          ),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            localizationDelegate
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: Constant.lang == "ar" ? Locale("ar") : Locale("en_US"),
          home: SplashScreen(
            seconds: 5,
            navigateAfterSeconds: Constant.token == null
                ? FirstVisitorPage()
                : RootPages(
                    checkPage: this.check,
                  ),
            backgroundColor: appColor,
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 150,
            onClick: () => print("D marketing"),
            loaderColor:colorWhite ,
            title: Text(
              "D marketing",
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold, color: colorWhite, fontSize: 20),
            ),
            image: Image.asset(
              "assets/images/logo.png",
              alignment: Alignment.bottomCenter,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
