import 'package:flutter/material.dart';

import 'common/routes/view_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    initialRoute: RoutesApp.loginSgnIn,
    onGenerateRoute: RoutesApp.generateRoute,
    // onGenerateInitialRoutes: (initialRoute) => [
    //   MaterialPageRoute(
    //     builder: (context) => const LoginForm(),
    //   )
    // ],
    debugShowCheckedModeBanner: false,
  ));
}
