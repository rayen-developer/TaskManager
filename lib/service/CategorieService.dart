import 'package:to_do_list/model/Categorie.dart';
import 'package:to_do_list/repository/repo.dart';

class CategorieService{
  Repository _repository;
  CategorieService(){
    _repository=Repository();
  }
  saveCategorie(Categorie categorie)async{
    return await _repository.insertData('categorie', categorie.categorieMap());

  }

  readcategorie()async{
    return await _repository.readData('categorie');
  }

  readcategorieById(categoryId)async {
    return await _repository.readDataById('categorie',categoryId);
  }

  updateCategorie(Categorie categorie)async{
    return await _repository.updateData('categorie',categorie.categorieMap());
  }

  deleteCategorie( categorieId) async{
    return await _repository.deleteCategory('categorie',categorieId);
  }
}