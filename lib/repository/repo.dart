import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/repository/dbconnection.dart';

class Repository{
  DataBaseConneection _dataBaseConneection;
  Repository(){
    _dataBaseConneection=DataBaseConneection();

  }
  static Database _database;

  Future<Database> get database async{
    if(_database!=null) return _database;
    _database=await _dataBaseConneection.setDataBase();
    return _database;

  }
  insertData(table,data )async{
    var connection=await database;
    return await connection.insert(table,data);
  }


  readData(table)async{
    var conection =await database;
    return await conection.query(table);
  }

  readDataById(table,categoryId) async{
    var connection=await database;
    return await connection.query(table,where: 'id=?',whereArgs: [categoryId]);
  }

  updateData(table,data)async {
    var connection=await database;
    return await connection.update(table,data,where: 'id=?',whereArgs: [data['id']]);
  }

  deleteCategory(table, categorieId)async {
    var connection=await database;
    return await connection.rawDelete("DELETE FROM $table WHERE id=$categorieId",);
  }
  readDataColumnName(table,columnName,columnValue)async{
    var conection =await database;
    return await conection.query(table,where: '$columnName=?',whereArgs: [columnValue]);
}

  deleteToDo(table, toDoId) async{
    var connection=await database;
    return await connection.rawDelete("DELETE FROM $table WHERE id=$toDoId",);


  }

}