import 'package:flutter/material.dart';
import 'package:simple_todo/models/tarea.model.dart';
import 'package:simple_todo/services/firebase_services.dart';
import 'package:simple_todo/utils/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final firestoreService = FirestoreService();
  final _controller = TextEditingController();
  late TabController _tabController;

  // Lista de instancias de Tarea
  List<Tarea> toDoList = [
    Tarea(nombreTarea: 'Contestar el foro de Física 2', estaFinalizada: true),
    Tarea(nombreTarea: 'Leer "Un viaje al centro de la Tierra"', estaFinalizada: true),
    Tarea(nombreTarea: 'Finalizar el proyecto final de programación', estaFinalizada: false),
    Tarea(nombreTarea: 'Repasar para el examen final de Cálculo', estaFinalizada: false),
  ];
  
@override
void initState() {
  super.initState();
  _tabController = TabController(length: 2, vsync: this);
  loadTasks(); // Cargar tareas cuando se inicializa el widget
}
  void checkBoxChanged(int index) {
    setState(() {
      toDoList[index].estaFinalizada = !toDoList[index].estaFinalizada;
    });
  }

void saveNewTask() {
  if (_controller.text.isNotEmpty) {
    setState(() {
      toDoList.add(Tarea(nombreTarea: _controller.text, estaFinalizada: false));
      firestoreService.saveList(toDoList); // Guarda la lista actualizada
      _controller.clear();
    });
  }
}
Future<void> loadTasks() async {
  final tareas = await firestoreService.getList();
  setState(() {
    toDoList = tareas;
  });
}


  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  Future<void> _editTask(int index) async {
    final TextEditingController editController = TextEditingController(text: toDoList[index].nombreTarea);
    
    final bool? shouldUpdate = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar tarea'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              hintText: 'Introduce el nuevo texto de la tarea',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Respuesta no
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Respuesta sí
              },
              child: const Text('Actualizar'),
            ),
          ],
        );
      },
    );

    if (shouldUpdate == true) {
      setState(() {
        toDoList[index].nombreTarea = editController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filtrar tareas pendientes y finalizadas
    List<Tarea> pendingTasks = toDoList.where((task) => !task.estaFinalizada).toList();
    List<Tarea> completedTasks = toDoList.where((task) => task.estaFinalizada).toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: const Text('To Do List'),
        backgroundColor: const Color.fromARGB(255, 68, 67, 70),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,  // Color del texto seleccionado
          unselectedLabelColor: Colors.grey,  // Color del texto no seleccionado
          indicatorColor: Colors.white,  // Color del indicador de la pestaña seleccionada
          tabs: const [
            Tab(text: 'Pendientes'),
            Tab(text: 'Finalizadas'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Pestaña de tareas pendientes
                ListView.builder(
                  itemCount: pendingTasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TodoList(
                      taskName: pendingTasks[index].nombreTarea,
                      taskCompleted: pendingTasks[index].estaFinalizada,
                      onChanged: (value) => checkBoxChanged(toDoList.indexOf(pendingTasks[index])),
                      deleteFunction: (context) => deleteTask(toDoList.indexOf(pendingTasks[index])),
                      editFunction: () => _editTask(toDoList.indexOf(pendingTasks[index])), // Pasar la función de edición
                    );
                  },
                ),
                // Pestaña de tareas finalizadas
                ListView.builder(
                  itemCount: completedTasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TodoList(
                      taskName: completedTasks[index].nombreTarea,
                      taskCompleted: completedTasks[index].estaFinalizada,
                      onChanged: (value) => checkBoxChanged(toDoList.indexOf(completedTasks[index])),
                      deleteFunction: (context) => deleteTask(toDoList.indexOf(completedTasks[index])),
                      editFunction: () => _editTask(toDoList.indexOf(completedTasks[index])), // Pasar la función de edición
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Añadir nueva tarea',
                      filled: true,
                      fillColor: const Color.fromARGB(255, 168, 168, 168),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 4, 0, 12),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: saveNewTask,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
