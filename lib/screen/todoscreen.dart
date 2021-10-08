import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/model/todo.dart';
import 'package:to_do_list/service/CategorieService.dart';
import 'package:to_do_list/service/todoservice.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _todoTitleController = TextEditingController();
  var _todoDescriptionController = TextEditingController();
  var _todoDateController = TextEditingController();

  var _categoires = List<DropdownMenuItem>();

  var _selectedValue;

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _loadCategorie();
    super.initState();
  }

  _loadCategorie() async {
    var _categoryService = CategorieService();
    var categories = await _categoryService.readcategorie();
    categories.forEach((category) {
      setState(() {
        _categoires.add(DropdownMenuItem(
          child: Text((category['name'])),
          value: category['name'],
        ));
      });
    });
  }

  DateTime _dateTime = DateTime.now();

  _selectedTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        _todoDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Add Todo'),
        backgroundColor: Color.fromRGBO(117, 81, 57, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                  controller: _todoTitleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'Write Todo Title',
                  )),
              TextField(
                controller: _todoDescriptionController,
                decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Write Todo Description'),
              ),
              TextField(
                controller: _todoDateController,
                decoration: InputDecoration(
                    labelText: 'Date',
                    hintText: 'Write Todo Date',
                    prefixIcon: InkWell(
                      onTap: () {
                        _selectedTodoDate(context);
                      },
                      child: Icon(Icons.calendar_today),
                    )),
              ),
              DropdownButtonFormField(
                value: _selectedValue,
                items: _categoires,
                hint: Text('Category'),
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () async {
                  var todoObject = Todo();
                  todoObject.title = _todoTitleController.text;
                  todoObject.description = _todoDescriptionController.text;
                  todoObject.finiched = 0;
                  todoObject.category = _selectedValue.toString();
                  todoObject.date = _todoDateController.text;
                  var _todoService = ToDoServise();
                  var result = await _todoService.saveToDo(todoObject);
                  if (result > 0) {
                    _showSuccessSnackBar(Text('To do created'));
                  }
                },
                color: Color.fromRGBO(242, 237, 215, 1),
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
