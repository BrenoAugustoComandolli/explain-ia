import 'package:chat_explain_ia/identidade_visual/cores_sistema.dart';
import 'package:chat_explain_ia/identidade_visual/i_theme_data.dart';
import 'package:flutter/material.dart';

class ThemeDataClaro implements IThemeData {
  @override
  ThemeData data() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: CoresSistema.primaryColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: CoresSistema.primaryColor,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(7),
              ),
              side: BorderSide(
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ),
      cardColor: CoresSistema.primaryColor,
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      useMaterial3: true,
    );
  }
}
