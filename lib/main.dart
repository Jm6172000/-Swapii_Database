import 'package:flutter/material.dart';
import 'package:app_movil1/screens/menu_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_movil1/database/database_helper.dart';
void main() async {
  // Inicializa la base de datos antes de ejecutar la aplicación
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseProvider().createDatabase();

  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swapii',
      home: const MenuScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(),
        scaffoldBackgroundColor: Colors.blue[100],
      ),
    );
  }
}
