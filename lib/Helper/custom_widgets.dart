import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wifyfood/main.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen();
  @override
  Widget build(BuildContext context) {
    bool isDarkMode;
    final themeChange = Provider.of<DarkThemeProvider>(context);
    isDarkMode = themeChange.darkTheme;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: isDarkMode ? Colors.grey[700] : Colors.red[50],
    );
  }
}

class BackgroundCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final length = MediaQuery.of(context).size.width;
    bool isDarkMode;
    final themeChange = Provider.of<DarkThemeProvider>(context);
    isDarkMode = themeChange.darkTheme;

    return Transform.translate(
      offset: Offset(MediaQuery.of(context).size.width * 0.25, -60),
      child: Container(
        height: length,
        width: length,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Colors.red[100],
          borderRadius: BorderRadius.circular(500),
        ),
      ),
    );
  }
}

// Circular Loader on TOP of the entire screen
Widget loader(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    color: Colors.black12,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
