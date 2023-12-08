import 'package:app_movil1/screens/screens.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(
          'https://swapiio.netlify.app/dark_swapii.png',
          fit: BoxFit.cover,
          height: 50,
          width: 50,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormScreen(),
                ),
              );
            },
            child: const Text('Iniciar Sesión', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormulariosScreen(),
                ),
              );
            },
            child: const Text('Crear Cuenta', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.network(
            'https://neubox.com/blog/wp-content/uploads/2021/11/860x436-TIENDA.webp',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: Container(
              color: Colors.blue[50],
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Quiénes somos',
                    style: TextStyle(fontSize: 30, color: Colors.black, fontFamily: 'Roboto'),
                  ),
                  const Text(
                    'Swapii es una plataforma de compra, venta e intercambio dentro de la Universidad Tecnologica de Durango . Nuestra mision es brindar servicios de calidad a nuestros usuarios.',
                    style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Roboto'),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, 
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Sugerencias'),
                            content: const TextField(
                              decoration: InputDecoration(hintText: "Escribe aquí tu sugerencia..."),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Enviar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.lightbulb_outline),
                    label: const Text('Sugerencias'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
