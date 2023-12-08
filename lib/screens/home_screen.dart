import 'package:flutter/material.dart';
import 'package:app_movil1/screens/carrito.dart';
import 'package:app_movil1/screens/screens.dart';
import 'package:app_movil1/screens/suscripcion.dart';
import 'package:app_movil1/screens/ayuda.dart';
import 'package:app_movil1/models/modelsp.dart';

class HomeScreen extends StatelessWidget {
  final List<Productos> productos;

  const HomeScreen({super.key, required this.productos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swapii', style: TextStyle(fontSize: 25, color: Colors.white)),
        leading: PopupMenuButton<int>(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 1,
              child: Row(
                children: [
                  Icon(Icons.add, color: Colors.black),
                  Text('Subir producto'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 2,
              child: Row(
                children: [
                  Icon(Icons.message, color: Colors.black),
                  Text('Mensajes'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 3,
              child: Row(
                children: [
                  Icon(Icons.shopping_cart, color: Colors.black),
                  Text('Carrito'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 4,
              child: Row(
                children: [
                  Icon(Icons.subscriptions, color: Colors.black),
                  Text('Suscripcion'),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductosScreen(),
                  ),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Mensajes(),
                  ),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CarritoDeCompras(),
                  ),
                );
                break;
              case 4:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SusScreen(),
                  ),
                );
                break;
            }
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UsuarioScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.help, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AyudaPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          return _buildProductCard(
            context,
            productos[index].nombreP,
            productos[index].imagenP,
            '\$${productos[index].precioP.toStringAsFixed(2)}',
          );
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, String title, String imageUrl, String price) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Image.network(
                imageUrl,
                height: 100,
                width: 100,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return const Text('Error al cargar la imagen');
                },
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Guardado en el carrito'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 20, color: Colors.black)),
          Text(price, style: const TextStyle(fontSize: 16, color: Colors.green)),
        ],
      ),
    );
  }
}
