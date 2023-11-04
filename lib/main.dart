import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/hourly_weather_screen.dart';
import './provider/weather_provider.dart';
import './screens/weekly_weather_screen.dart';
import './screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        title: 'Flutter Weather',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          iconTheme: IconThemeData(
            color: Colors.pinkAccent,
          ),
          primaryColor: Colors.pinkAccent,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.pinkAccent,
            primary: Colors.pinkAccent,
            secondary: Colors.redAccent,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.pink.shade50,
            surfaceTintColor: Colors.pink.shade50,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.pinkAccent,
            foregroundColor: Colors.white,
          ),
          appBarTheme: const AppBarTheme(
            color: Colors.pinkAccent,
            surfaceTintColor: Colors.transparent,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.white,
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          useMaterial3: true,
          splashFactory: InkRipple.splashFactory,
          navigationBarTheme: NavigationBarThemeData(
            indicatorColor: Colors.pinkAccent,
            backgroundColor: Colors.pinkAccent[5],
          ),
        ),
        home: HomeScreen(),
        routes: {
          WeeklyScreen.routeName: (myCtx) => WeeklyScreen(),
          HourlyScreen.routeName: (myCtx) => HourlyScreen(),
        },
      ),
    );
  }
}
