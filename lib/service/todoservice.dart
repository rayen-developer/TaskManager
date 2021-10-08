import 'package:to_do_list/model/todo.dart';
import 'package:to_do_list/repository/repo.dart';

class ToDoServise{
  Repository _repository;
  ToDoServise(){
    _repository=Repository();
  }
  saveToDo(Todo todo)async{
    return await _repository.insertData('todo', todo.toDoMap());

  }

  readToDo()async{
    return await _repository.readData('todo');
  }
  readToDoByCategory(category)async{
    return await _repository.readDataColumnName('todo','category',category);
  }

  deleteTodo(toDoId) async{
    return await _repository.deleteToDo('todo',toDoId);
  }

  updateTodo(Todo todo)async {
    return await _repository.updateData('todo',todo.toDoMap());

  }

}