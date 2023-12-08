import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Usuario {
  String usuario;
  String email;
  String contrasena;
  String imagenUsuario;

  Usuario({
    required this.usuario,
    required this.email,
    required this.contrasena,
    required this.imagenUsuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'usuario': usuario,
      'email_2': email,
      'contraseña_2': contrasena,
      'imagen_usuario': imagenUsuario,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      usuario: map['usuario'],
      email: map['email_2'],
      contrasena: map['contraseña_2'],
      imagenUsuario: map['imagen_usuario'],
    );
  }
}

class DatabaseProvider {
  static const String TABLE_USUARIO = "usuario";
  static const String COLUMN_NOMBRE_USUARIO = "nombre_usuario";
  static const String COLUMN_CONTRASENA_USUARIO = "contraseña_usuario";
  static const String COLUMN_IMAGEN_USUARIO = "imagen_usuario";
  static const String COLUMN_GUARDADOS = "guardados";
  static const String COLUMN_EMAIL_USUARIO = "email_usuario";

  Future<Database> createDatabase() async {
    String path = join(await getDatabasesPath(), "my_database.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $TABLE_USUARIO (
            $COLUMN_NOMBRE_USUARIO TEXT PRIMARY KEY,
            $COLUMN_CONTRASENA_USUARIO TEXT,
            $COLUMN_IMAGEN_USUARIO TEXT,
            $COLUMN_GUARDADOS TEXT,
            $COLUMN_EMAIL_USUARIO TEXT
          )
        ''');
      },
    );
  }
}

class FormulariosScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final DatabaseProvider _databaseProvider = DatabaseProvider();

  FormulariosScreen({super.key});

  Future<void> _insertarUsuarioEnBD(Usuario usuario) async {
    final Database db = await _databaseProvider.createDatabase();
    await db.insert(
      DatabaseProvider.TABLE_USUARIO,
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cuenta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFormBox(
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Usuario',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa un nombre de usuario';
                    }
                    return null;
                  },
                ),
              ),
              _buildFormBox(
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo Electrónico',
                    prefixIcon: Icon(Icons.email),
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
                ),
              ),
              _buildFormBox(
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock),
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
                ),
              ),
              _buildFormBox(
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Contraseña',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirma tu contraseña';
                    }
                    if (value != _passwordController.text) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
              ),
              _buildFormBox(
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final nombre = _nombreController.text;
                      final email = _emailController.text;

                      Usuario nuevoUsuario = Usuario(
                        usuario: nombre,
                        email: email,
                        contrasena: _passwordController.text,
                        imagenUsuario: 'imagen_por_defecto.jpg',
                      );

                      await _insertarUsuarioEnBD(nuevoUsuario);

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Bienvenido'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Usuario: $nombre'),
                                Text('Email: $email'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  // Aquí podrías navegar a otra pantalla si es necesario
                                },
                                child: const Text('Aceptar'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Registrarse'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormBox(Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
