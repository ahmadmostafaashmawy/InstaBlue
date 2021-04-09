import 'package:insta_blue/screen/device_screen.dart';
import 'package:insta_blue/screen/home_screen.dart';
import 'package:insta_blue/screen/splash_screen.dart';

class AppRoute {
  static const Splash = '/';
  static const Home = '/home';
  static const DeviceScreen = '/deviceScreen';
}

var routes = {
  AppRoute.Splash: (context) => SplashScreen(),
  AppRoute.Home: (context) => HomeScreen(),
  AppRoute.DeviceScreen: (context) => DeviceScreen(),
};
