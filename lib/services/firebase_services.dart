import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_todo/models/tarea.model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Guardar la lista de tareas en Firestore
  Future<void> saveList(List<Tarea> tareas) async {
    final List<Map<String, dynamic>> tareasMap = tareas.map((tarea) => tarea.toMap()).toList();

    await _db.collection('tasks').doc('userTasks').set({
      'tareas': tareasMap,
    });
  }

  // Recuperar la lista de tareas de Firestore
  Future<List<Tarea>> getList() async {
    final doc = await _db.collection('tasks').doc('userTasks').get();
    final data = doc.data();
    if (data != null && data.containsKey('tareas')) {
      final List<dynamic> tareasList = data['tareas'];
      return tareasList.map((tareaMap) => Tarea.fromMap(Map<String, dynamic>.from(tareaMap))).toList();
    }
    return [];
  }
}
