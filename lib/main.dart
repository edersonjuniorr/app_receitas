import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/ingredients_scan_screen.dart';
import 'providers/favorites_provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesProvider(), // Crie uma instância de FavoritesProvider
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primaryColor: Color(0xFFF29F05),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFFF29F05),
          secondary: Color(0xFFF28705),
        ),
        scaffoldBackgroundColor: Color(0xFFF2DDB6),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFF29F05),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF29F05), // background color
            foregroundColor: Colors.white, // text color
          ),
        ),
      ),
      home: HomeScreen(),
      routes: {
        '/scan': (context) => IngredientsScanScreen(cuisine: ''),
      },
    );
  }
}
