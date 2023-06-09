import 'package:flutter/material.dart';

class UserAppBar extends StatelessWidget implements PreferredSizeWidget {
  IconButton icon;
  TextEditingController controller;
  
  UserAppBar({
    super.key,
    required this.icon,
    required this.controller,
    
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: 8.0),
          Text(
            "Editar Usuário: ${controller.text}",
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon,
        ],
      ),
    );
  }
}