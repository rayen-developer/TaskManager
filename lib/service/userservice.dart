import 'package:to_do_list/model/user.dart';
import 'package:to_do_list/repository/repo.dart';

class UserServise{
  Repository _repository;
  UserServise(){
    _repository=Repository();
  }
  saveUser(User user)async{
    return await _repository.insertData('user', user.userMap());

}

  readUser()async {
    return await _repository.readData('user');
  }}