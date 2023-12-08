// Model for the "carrito" table
class Carrito {
  String guardados;
  String usuarioC;

  Carrito({required this.guardados, required this.usuarioC});

  Map<String, dynamic> toMap() {
    return {
      'guardados_2': guardados,
      'usuario_c': usuarioC,
    };
  }

  factory Carrito.fromMap(Map<String, dynamic> map) {
    return Carrito(
      guardados: map['guardados_2'],
      usuarioC: map['usuario_c'],
    );
  }
}