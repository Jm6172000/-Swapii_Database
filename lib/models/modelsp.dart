// Model for the "productos" table
class Productos {
  String nombreP;
  String imagenP;
  String usuarioP;
  double precioP;
  int cantidadP;
  String descripcionP;

  Productos({
    required this.nombreP,
    required this.imagenP,
    required this.usuarioP,
    required this.precioP,
    required this.cantidadP,
    required this.descripcionP,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre_p': nombreP,
      'imagen_p': imagenP,
      'usuario_p': usuarioP,
      'precio_p': precioP,
      'cantidad_p': cantidadP,
      'descripcion_p': descripcionP,
    };
  }

  factory Productos.fromMap(Map<String, dynamic> map) {
    return Productos(
      nombreP: map['nombre_p'],
      imagenP: map['imagen_p'],
      usuarioP: map['usuario_p'],
      precioP: map['precio_p'],
      cantidadP: map['cantidad_p'],
      descripcionP: map['descripcion_p'],
    );
  }
}
