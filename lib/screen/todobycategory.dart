import 'package:flutter/material.dart';
import 'package:to_do_list/model/todo.dart';
import 'package:to_do_list/service/todoservice.dart';

class ToDoByCategory extends StatefulWidget {
  String category;

  ToDoByCategory({this.category});

  @override
  _ToDoByCategoryState createState() => _ToDoByCategoryState();
}

class _ToDoByCategoryState extends State<ToDoByCategory> {
  List<Todo> _todoList = List<Todo>();
  ToDoServise _todoService = ToDoServise();

  @override
  void initState() {
    super.initState();
    getTodosByCategories();
  }

  getTodosByCategories() async {
    var todos = await _todoService.readToDoByCategory(this.widget.category);
    print(this.widget.category);
    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.title = todo['title'];
        model.description = todo['description'];
        model.finiched = todo['finiched'];
        model.date = todo['date'];
        model.category = todo['category'];
        _todoList.add(model);
        print(model);
      });
    });
  }

  Widget  etatFunction(int num)  {
    if (num == 1) {
      return Text(
        'Done',
        style:TextStyle(
          color: Colors.green
        ),
      );
    }else{
      return Text(
        'Not done',style: TextStyle(
        color: Colors.red
      ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black, title: Text(this.widget.category)),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _todoList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        elevation: 8,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[Text(_todoList[index].title)],
                          ),
                          subtitle: Text(
                              _todoList[index].description ?? 'No description'),
                          trailing: Text(_todoList[index].date ?? 'No date'),
                          leading: etatFunction(_todoList[index].finiched),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
