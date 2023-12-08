import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AyudaPage extends StatefulWidget {
  const AyudaPage({super.key});

  @override
  _AyudaPageState createState() => _AyudaPageState();
}

class _AyudaPageState extends State<AyudaPage> {
  final List<String> mensajes = [];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _quejaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicio de Ayuda'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOptionBox(
                context,
                'Quejas',
                '¿Algo no fue como esperabas?¿No te entregaron tu pedido?',
                Colors.orange.shade100,
                onOptionSelected: () => _showInputDialog('Quejas'),
              ),
              _buildOptionBox(
                context,
                'Sugerencias',
                '¿Tienes ideas para mejorar nuestra plataforma?',
                Colors.green.shade100,
                onOptionSelected: () => _showInputDialog('Sugerencias'),
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
                    color: Colors.blue[100],
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
          Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.purple[100],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '¿Necesitas más ayuda?',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Si tus preguntas no fueron respondidas, estamos aquí para ayudarte. ¡Contacta con nosotros!',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _launchEmail('andreagal2004@gmail.com', 'Asunto: Ayuda', '');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  child: const Text('Obtener más ayuda'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionBox(
    BuildContext context,
    String title,
    String description,
    Color color, {
    VoidCallback? onOptionSelected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onOptionSelected,
        child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                description,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInputDialog(String option) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Escribir $option'),
          content: Column(
            children: [
              TextField(
                controller: _quejaController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Escribe aquí tu $option',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _enviarQueja(option);
                  Navigator.of(context).pop();
                },
                child: Text('Enviar $option'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _enviarQueja(String option) {
    // Enviar la queja por correo electrónico
    _launchEmail('andreagal2004@gmail.com', 'Queja o Sugerencia', _quejaController.text);

    // No agregar la queja a la lista para que no se muestre en la página
    _quejaController.clear();
  }

  void _launchEmail(String toEmail, String subject, String body) async {
    final url = 'mailto:$toEmail?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo lanzar el correo electrónico';
    }
  }
}
