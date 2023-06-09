import 'package:flutter/material.dart';
import 'package:login_with_sqllite/model/user_model.dart';
import 'package:login_with_sqllite/screen/list_book_form.dart';
import 'package:login_with_sqllite/screen/login_form.dart';
import 'package:login_with_sqllite/screen/signup_form.dart';
import 'package:login_with_sqllite/screen/update_form.dart';
import 'package:login_with_sqllite/screen/create_book_form.dart';

class RoutesApp {
  static const loginSgnIn = '/';
  static const loginSgnup = '/loginSignup';
  static const loginUpdate = '/loginUpdate';
  static const listBook = '/listBook';
  static const createBook = '/createBook';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case loginSgnIn:
        return MaterialPageRoute(builder: (context) => const LoginForm());

      case loginSgnup:
        return MaterialPageRoute(builder: (context) => const SignUp());

      case loginUpdate:
        if (arguments is UserModel) {
          return MaterialPageRoute(
            // builder: (context) => UdpateUser(arguments),
            builder: (context) => const UpdateUser(),
            settings: settings,
          );
        } else {
          return _errorRoute();
        }
      case createBook:
        return MaterialPageRoute(
          builder: (context) => CreateBook(user: arguments as UserModel),
          settings: settings,
        );

      case listBook:
        return MaterialPageRoute(
          builder: (context) => ListBook(user: arguments as UserModel),
          settings: settings,
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
