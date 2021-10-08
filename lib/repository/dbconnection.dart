import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DataBaseConneection{
  setDataBase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path,'dbTodoList');
    var database =await openDatabase(path,version: 1,onCreate:_onCreateDataBase);
    return database;
  }
  _onCreateDataBase(Database database,int version)async{
    await database.execute('CREATE TABLE categorie(id INTEGER PRIMARY KEY,name TEXT,description TEXT)');

    await database.execute('CREATE TABLE todo(id INTEGER PRIMARY KEY,title TEXT,description TEXT,category TEXT,date, TEXT,finiched INTEGER)');

    await database.execute('CREATE TABLE user(id INTEGER PRIMARY KEY,username TEXT,password TEXT)');

  }
}