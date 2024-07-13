import 'package:flutter/material.dart';

SnackBar makeSnackBar({required IconData icon, required String text, required Color backgroundColor}) => SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    padding: EdgeInsets.zero,
    showCloseIcon: true,
    content: Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.red),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    ));

//Icons.error
//usuário já existe.