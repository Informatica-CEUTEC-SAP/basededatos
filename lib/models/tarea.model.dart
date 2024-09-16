class Tarea {
  String nombreTarea;
  bool estaFinalizada;

  Tarea({required this.nombreTarea, required this.estaFinalizada});

  // Convierte el objeto a un mapa
  Map<String, dynamic> toMap() {
    return {
      'nombreTarea': nombreTarea,
      'estaFinalizada': estaFinalizada,
    };
  }

  // Crea una instancia de Tarea desde un mapa
  factory Tarea.fromMap(Map<String, dynamic> map) {
    return Tarea(
      nombreTarea: map['nombreTarea'] ?? '',
      estaFinalizada: map['estaFinalizada'] ?? false,
    );
  }
}
