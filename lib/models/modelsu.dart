// Combined Model for the "crear" and "usuario" tables
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