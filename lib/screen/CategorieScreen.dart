import 'package:flutter/material.dart';
import 'package:to_do_list/model/Categorie.dart';
import 'package:to_do_list/screen/HomeScreen.dart';
import 'package:to_do_list/service/CategorieService.dart';

class CategorieScreen extends StatefulWidget {
  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  var _categorieNameController = TextEditingController();
  var _categorieDescriptionController = TextEditingController();
  var _editcategorieNameController = TextEditingController();
  var _editcategorieDescriptionController = TextEditingController();
  var _categorie = Categorie();
  var _categorieService = CategorieService();
  var category;
  List<Categorie> _categorieList = List<Categorie>();

  @override
  void initState() {
    super.initState();
    getAllCategorie();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  getAllCategorie() async {
    _categorieList = List<Categorie>();
    var categories = await _categorieService.readcategorie();
    categories.forEach((c) {
      setState(() {
        var categoryModel = Categorie();
        categoryModel.name = c['name'];
        categoryModel.description = c['description'];
        categoryModel.id = c['id'];
        _categorieList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categorieService.readcategorieById(categoryId);
    setState(() {
      _editcategorieNameController.text = category[0]['name'] ?? 'No name!!';
      _editcategorieDescriptionController.text =
          category[0]['description'] ?? 'No description!!';
    });
    _editFormDialod(context);
  }

  _showFormDialod(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  _categorie.name = _categorieNameController.text;
                  _categorie.description = _categorieDescriptionController.text;
                  var result =
                      await _categorieService.saveCategorie(_categorie);
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllCategorie();
                  }
                },
                child: Text('Save'),
                color: Color.fromRGBO(117, 81, 57, 1),
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Exit'),
                color: Color.fromRGBO(242, 237, 215, 1),
              )
            ],
            title: Text('Add categorie'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _categorieNameController,
                    decoration: InputDecoration(
                        labelText: 'Categorie', hintText: 'Write a categorie'),
                  ),
                  TextField(
                    controller: _categorieDescriptionController,
                    decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Write a description'),
                  )
                ],
              ),
            ),
          );
        });
  }

  _editFormDialod(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  _categorie.id = category[0]['id'];
                  _categorie.name = _editcategorieNameController.text;
                  _categorie.description =
                      _editcategorieDescriptionController.text;
                  var result =
                      await _categorieService.updateCategorie(_categorie);
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllCategorie();
                    _showSuccessSnackBar(Text('Updated'));
                  }
                },
                child: Text('Save'),
                color: Colors.black,
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Exit'),
                color: Colors.black,
              )
            ],
            title: Text('edit categorie'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _editcategorieNameController,
                    decoration: InputDecoration(
                        labelText: 'Categorie', hintText: 'Write a categorie'),
                  ),
                  TextField(
                    controller: _editcategorieDescriptionController,
                    decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Write a description'),
                  )
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialod(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  var result =
                      await _categorieService.deleteCategorie(categoryId);
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllCategorie();
                    _showSuccessSnackBar(Text('Deleted'));
                  }
                },
                child: Text('Delete'),
                color: Colors.red,
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Exit'),
                color: Color.fromRGBO(242, 237, 215, 1),
              )
            ],
            title: Text('are you sure!'),
          );
        });
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
        title: Text('Categories'),
        leading: RaisedButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen())),
          child: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(242, 237, 215, 1),
          ),
          color: Color.fromRGBO(117, 81, 57, 1),
          elevation: 0.0,
        ),
        backgroundColor: Color.fromRGBO(117, 81, 57, 1),
      ),
      body: ListView.builder(
          itemCount: _categorieList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editCategory(context, _categorieList[index].id);
                    },
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_categorieList[index].name),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteFormDialod(context, _categorieList[index].id);
                        },
                      ),
                    ],
                  ),
                  subtitle: Text(_categorieList[index].description),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialod(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(117, 81, 57, 1),
      ),
    );
  }
}
