import 'package:flutter/material.dart';
import 'package:app_movil1/screens/home_screen.dart';
import 'package:app_movil1/database/database_helper.dart';

class FormScreen extends StatelessWidget {
   FormScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration:const  InputDecoration(
                  labelText: 'Correo Electrónico',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa un correo electrónico';
                  }
                  if (!value.contains('@') || !value.endsWith('.com')) {
                    return 'Ingresa un correo electrónico válido';
                  }
                  return null;
                },
              ), const
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa una contraseña';
                  }
                  if (value.length <= 5) {
                    return 'La contraseña debe tener más de 5 caracteres';
                  }
                  return null;
                },
                obscureText: true,
              ), const
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool isAuthenticated = await _authService.authenticate(
                      _emailController.text,
                      _passwordController.text,
                    );

                    if (isAuthenticated) { 
                      Navigator.pushReplacement( 
                        context, 
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(productos: []),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Correo electrónico o contraseña incorrectos.'),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Ingresar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*   Future<bool> verificarCredenciales(String email, String contrasena) async {
    Database db = await DatabaseProvider().createDatabase();
    List<Map<String, dynamic>> result = await db.query(
      DatabaseProvider.TABLE_INICIO_SESION,
      where: "email = ? AND contrasena = ?",
      whereArgs: [email, contrasena],
    );
    return result.isNotEmpty;
  }*/
} 

class AuthService {
  final DatabaseProvider _databaseProvider = DatabaseProvider();

  Future<bool> authenticate(String email, String password) async {
    Database db = await _databaseProvider.createDatabase();
    List<Map<String, dynamic>> result = await db.query(
      DatabaseProvider.TABLE_INICIO_SESION,
      where: "${DatabaseProvider.COLUMN_EMAIL} = ? AND ${DatabaseProvider.COLUMN_CONTRASENA} = ?",
      whereArgs: [email, password],
    );
    return result.isNotEmpty;
  }
}




/* void main() {
  runApp(
    MaterialApp(
      home: FormScreen(),
    ),
  );
}
 */