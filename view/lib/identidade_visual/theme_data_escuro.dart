import 'package:chat_explain_ia/identidade_visual/cores_sistema.dart';
import 'package:chat_explain_ia/identidade_visual/i_theme_data.dart';
import 'package:flutter/material.dart';

class ThemeDataEscuro implements IThemeData {
  @override
  ThemeData data() {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: CoresSistema.primaryColor,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: CoresSistema.primaryColor,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      cardColor: CoresSistema.primaryColor,
      useMaterial3: true,
    );
  }
}
