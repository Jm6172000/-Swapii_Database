import 'package:flutter/material.dart';

class SusScreen extends StatefulWidget {
  const SusScreen({super.key});

  @override
  _SusScreenState createState() => _SusScreenState();
}

class _SusScreenState extends State<SusScreen> {
  final List<String> mensajes = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suscripción'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.purple[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gratis',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        '\$0/mes',
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        '- Compras sin limite',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const Text(
                        '- Catalogo completo',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const Text(
                        '- Publicaciones ilimitadas',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                        
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                        ),
                        child: const Text('Seguir en Gratuito'),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Suscripción Pro',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        '\$50/mes',
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    
                      const Text(
                        '- Compras sin limite',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const Text(
                        '- Mayor personalizacion de usuario',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const Text(
                        '- Preferencias de usuario',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                         
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text('Suscribirse'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: mensajes.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    mensajes[index],
                    style: const TextStyle(fontSize: 16.0),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
