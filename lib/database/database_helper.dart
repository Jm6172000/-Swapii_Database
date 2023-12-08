import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static const String TABLE_INICIO_SESION = "inicio_sesion";
  static const String COLUMN_EMAIL = "email";
  static const String COLUMN_CONTRASENA = "contraseña";

  static const String TABLE_PRODUCTOS = "productos";
  static const String COLUMN_NOMBRE_P = "nombre_p";
  static const String COLUMN_IMAGEN_P = "imagen_p";
  static const String COLUMN_USUARIO_P = "usuario_p";
  static const String COLUMN_PRECIO_P = "precio_p";
  static const String COLUMN_CANTIDAD_P = "cantidad_p";
  static const String COLUMN_DESCRIPCION_P = "descripcion_p";

  // Combined TABLE_USUARIO with TABLE_CREAR
  static const String TABLE_USUARIO = "usuario";
  static const String COLUMN_NOMBRE_USUARIO = "nombre_usuario";
  static const String COLUMN_CONTRASENA_USUARIO = "contraseña_usuario";
  static const String COLUMN_IMAGEN_USUARIO = "imagen_usuario";
  static const String COLUMN_GUARDADOS = "guardados";
  static const String COLUMN_EMAIL_USUARIO = "email_usuario";

  static const String TABLE_CARRITO = "carrito";
  static const String COLUMN_GUARDADOS_2 = "guardados";
  static const String COLUMN_USUARIO_C = "usuario_c";

  Future<Database> createDatabase() async {
    String path = join(await getDatabasesPath(), "my_database.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $TABLE_INICIO_SESION (
            $COLUMN_EMAIL TEXT PRIMARY KEY,
            $COLUMN_CONTRASENA TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE $TABLE_USUARIO (
            $COLUMN_NOMBRE_USUARIO TEXT PRIMARY KEY,
            $COLUMN_CONTRASENA_USUARIO TEXT,
            $COLUMN_IMAGEN_USUARIO TEXT,
            $COLUMN_GUARDADOS TEXT,
            $COLUMN_EMAIL_USUARIO TEXT,
            FOREIGN KEY ($COLUMN_EMAIL_USUARIO) REFERENCES $TABLE_INICIO_SESION($COLUMN_EMAIL)
          )
        ''');
        await db.execute('''
          CREATE TABLE $TABLE_PRODUCTOS (
            $COLUMN_NOMBRE_P TEXT PRIMARY KEY,
            $COLUMN_IMAGEN_P TEXT,
            $COLUMN_USUARIO_P TEXT,
            $COLUMN_PRECIO_P REAL,
            $COLUMN_CANTIDAD_P INTEGER,
            $COLUMN_DESCRIPCION_P TEXT,
            FOREIGN KEY ($COLUMN_USUARIO_P) REFERENCES $TABLE_USUARIO($COLUMN_NOMBRE_USUARIO)
          )
        ''');
        await db.execute('''
          CREATE TABLE $TABLE_CARRITO (
            $COLUMN_GUARDADOS_2 TEXT,
            $COLUMN_USUARIO_C TEXT,
            FOREIGN KEY ($COLUMN_USUARIO_C) REFERENCES $TABLE_USUARIO($COLUMN_NOMBRE_USUARIO)
          )
        ''');
      },
    );
  }
}
