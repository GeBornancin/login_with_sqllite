import 'package:flutter/material.dart';

class UserLoginHeader extends StatelessWidget {
  final String nameHeader;
  const UserLoginHeader(this.nameHeader, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          nameHeader,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 20),
        Image.asset(
          'assets/images/livro.png',
          height: 200,
        ),
        const SizedBox(height: 20),
        const Text(
          'BookPoint',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
