import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CarritoDeCompras extends StatefulWidget {
  const CarritoDeCompras({super.key});

  @override
  _CarritoDeComprasState createState() => _CarritoDeComprasState();
}

class _CarritoDeComprasState extends State<CarritoDeCompras> {
  late Database _database;
  final List<Producto> productosEnCarrito = [];

  @override
  void initState() {
    super.initState();
    _abrirBaseDeDatos();
  }

  Future<void> _abrirBaseDeDatos() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'productos_database.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE productos (
            id INTEGER PRIMARY KEY,
            nombre TEXT,
            precio REAL
          )
        ''');
        db.execute('''
          CREATE TABLE carrito (
            id INTEGER PRIMARY KEY,
            producto_id INTEGER,
            FOREIGN KEY (producto_id) REFERENCES productos(id)
          )
        ''');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: FutureBuilder<List<Producto>>(
        future: _obtenerProductosEnCarrito(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].nombre),
                subtitle: Text('\$${snapshot.data![index].precio.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    _eliminarProductoDelCarrito(snapshot.data![index].id!);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarDialogoAgregarProducto(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _mostrarDialogoAgregarProducto(BuildContext context) async {
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController precioController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Producto'),
          content: Column(
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre del Producto'),
              ),
              TextField(
                controller: precioController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _agregarProducto(nombreController.text, double.tryParse(precioController.text) ?? 0.0);
                Navigator.of(context).pop();
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _agregarProducto(String nombre, double precio) async {
    final idProducto = await _insertarProducto(Producto(nombre, precio));
    await _insertarProductoEnCarrito(idProducto);
  }

  Future<int> _insertarProducto(Producto producto) async {
    return await _database.insert(
      'productos',
      producto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> _insertarProductoEnCarrito(int productoId) async {
    await _database.insert(
      'carrito',
      {'producto_id': productoId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Producto>> _obtenerProductosEnCarrito() async {
    final List<Map<String, dynamic>> productosEnCarritoMap = await _database.rawQuery('''
      SELECT productos.id, productos.nombre, productos.precio 
      FROM productos 
      JOIN carrito ON productos.id = carrito.producto_id
    ''');

    return List.generate(productosEnCarritoMap.length, (index) {
      return Producto(
        productosEnCarritoMap[index]['nombre'],
        productosEnCarritoMap[index]['precio'],
        id: productosEnCarritoMap[index]['id'],
      );
    });
  }

  Future<void> _eliminarProductoDelCarrito(int productoId) async {
    await _database.delete('carrito', where: 'producto_id = ?', whereArgs: [productoId]);
    setState(() {});
  }
}

class Producto {
  final int? id;
  final String nombre;
  final double precio;

  Producto(this.nombre, this.precio, {this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
    };
  }
}

void main() {
  runApp(const MaterialApp(
    home: CarritoDeCompras(),
  ));
}
