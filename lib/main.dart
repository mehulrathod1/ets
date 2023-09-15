import 'package:etsemployee/Screens/HomeDashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'CompanyPortal/CompanyScreens/company_dashboard.dart';
import 'CompanyPortal/CompanyScreens/company_login_screen.dart';
import 'Screens/SignIn.dart';
import 'Screens/Splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterDownloader.initialize(
  //     debug: true // Set it to false in release mode
  //     );
  await FlutterDownloader.initialize(debug: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xffEAEAEA), unselectedWidgetColor: const Color(0xff231F20)),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => makeRoute(context: context, routeName: settings.name, arguments: settings.arguments),
            maintainState: true,
            fullscreenDialog: false,
          );
        }
        /* home: const Splash(),*/
        );
  }

  Widget makeRoute({required BuildContext context, required String? routeName, Object? arguments}) {
    final Widget child = _buildRoute(context: context, routeName: routeName, arguments: arguments);
    return child;
  }

  Widget _buildRoute({
    required BuildContext context,
    required String? routeName,
    Object? arguments,
  }) {
    switch (routeName) {
      case '/':
        return const Splash();
      case '/loginEmployee':
        return const SignIn();
      case '/loginCompany':
        return const CompanyLoginScreen();
      case '/employeeDashbord':
        return const HomeDashboard(currentTableSelected: 0,);
        case '/home':
        return const CompanyDashboard();
      default:
        throw 'Route $routeName is not defined';
    }
  }
}
