import 'package:flutter/material.dart';
import 'package:to_do_list/helper/DrawerNavigation.dart';
import 'package:to_do_list/model/todo.dart';
import 'package:to_do_list/screen/todoscreen.dart';
import 'package:to_do_list/service/todoservice.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  ToDoServise _toDoServise;
  List<Todo> _ToDolist = List<Todo>();

  @override
  void initState() {
    super.initState();
    getAllTodo();
  }

  getAllTodo() async {
    _toDoServise = ToDoServise();
    _ToDolist = List<Todo>();
    var todos = await _toDoServise.readToDo();
    todos.forEach((t) {
      setState(() {
        var ToDoModel = Todo();
        ToDoModel.title = t['title'];
        ToDoModel.description = t['description'];
        ToDoModel.id = t['id'];
        ToDoModel.finiched = t['finiched'];
        ToDoModel.date = t['date'];
        ToDoModel.category = t['category'];
        _ToDolist.add(ToDoModel);
      });
    });
  }

  _deleteFormDialod(BuildContext context, message, Todo todo) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  var result = await _toDoServise.deleteTodo(todo.id);
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllTodo();
                  }
                },
                child: Text('Delete'),
                color: Colors.black26,
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Exit'),
                color: Colors.black,
              ),
            ],
            title: Text(message),
          );
        });
  }

  _doneFormDialod(BuildContext context, message, Todo todo) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  var result = await _toDoServise.deleteTodo(todo.id);
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllTodo();
                  }
                },
                child: Text('Delete'),
                color: Colors.red,
              ),
              FlatButton(
                onPressed: () async {
                  todo.finiched = 1;
                  var result = await _toDoServise.updateTodo(todo);
                  Navigator.pop(context);
                },
                child: Text('Make it done'),
                color: Colors.green,
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Exit'),
                color: Color.fromRGBO(242, 237, 215, 1),
              ),
            ],
            title: Text(message),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do App'),
        backgroundColor: Color.fromRGBO(117, 81, 57, 1),
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(
          itemCount: _ToDolist.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  child: ListTile(
                    subtitle: Text(_ToDolist[index].category ?? 'No category'),
                    trailing: Text(_ToDolist[index].date ?? 'No date'),
                    onTap: () {
                      print(_ToDolist[index]);
                      if (_ToDolist[index].finiched == 1) {
                        _deleteFormDialod(
                            context, 'todo is done', _ToDolist[index]);
                      } else {
                        _doneFormDialod(
                            context, 'todo not done', _ToDolist[index]);
                      }
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_ToDolist[index].title ?? 'No Title'),
                      ],
                    ),
                  )),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => TodoScreen())),
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(117, 81, 57, 1),
      ),
    );
  }
}
