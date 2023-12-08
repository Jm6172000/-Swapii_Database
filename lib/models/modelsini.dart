class InicioSesion {
  String email;
  String contrasena;

  InicioSesion({required this.email, required this.contrasena});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'contrasena': contrasena,
    };
  }

  factory InicioSesion.fromMap(Map<String, dynamic> map) {
    return InicioSesion(
      email: map['email'],
      contrasena: map['contrasena'],
    );
  }
}
