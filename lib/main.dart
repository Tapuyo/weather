import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather/provider/user_provider.dart';
import 'package:weather/provider/weather_forecast_provider.dart';
import 'package:weather/routes/route_generator.dart';
import 'package:weather/routes/routes.dart';
import 'package:weather/ui/login.dart';
import 'package:weather/utils/themes.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child:  MyApp(),
  ));
}

class MyApp extends StatelessWidget {

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  const LoginPage(),
      title: 'Payong',
      initialRoute: Routes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        platform: TargetPlatform.iOS,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 1,
          color: Colors.white,
          iconTheme: IconThemeData(
            color: kColorPrimary,
          ),
          actionsIconTheme: IconThemeData(
            color: kColorPrimary,
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        dividerColor: Colors.grey[300],
       
        iconTheme: const IconThemeData(
          color: kColorPrimary,
        ),
        fontFamily: 'NunitoSans',
        cardTheme: CardTheme(
          elevation: 0,
          color: const Color(0xffEBF2F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            //side: BorderSide(width: 1, color: Colors.grey[200]),
          ),
        ),
      ),
    );
  }

    
}
