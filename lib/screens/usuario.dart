import 'package:flutter/material.dart';

class UsuarioScreen extends StatefulWidget {
  const UsuarioScreen({super.key});

  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<UsuarioScreen> {
  String password = 'Contraseña';
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://img.freepik.com/vector-premium/icono-circulo-usuario-anonimo-ilustracion-vector-estilo-plano-sombra_520826-1931.jpg'),
            ),
            TextButton(
              child: const Text('Cambiar imagen'),
              onPressed: () {
            
              },
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre de usuario',
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Correo electrónico',
              ),
            ),
            TextField(
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Cambiar Contraseña',
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            TextButton(
              child: const Text('Eliminar cuenta'),
              onPressed: () {
   
              },
            ),
          ],
        ),
      ),
    );
  }
}
