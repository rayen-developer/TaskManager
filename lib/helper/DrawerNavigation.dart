import 'package:flutter/material.dart';
import 'package:to_do_list/screen/CategorieScreen.dart';
import 'package:to_do_list/screen/HomeScreen.dart';
import 'package:to_do_list/screen/loginScreen.dart';
import 'package:to_do_list/screen/todobycategory.dart';
import 'package:to_do_list/service/CategorieService.dart';
import 'package:to_do_list/source/app.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _categoryList = List<Widget>();
  CategorieService _categorieService = CategorieService();

  getAllCategories() async {
    var categories = await _categorieService.readcategorie();

    categories.forEach((category) {
      setState(() {
        _categoryList.add(InkWell(
          onTap: () => Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new ToDoByCategory(
                        category: category['name'],
                      ))),
          child: ListTile(
            title: Text(category['name']),
          ),
        ));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAllCategories();
    print(_categoryList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://image.flaticon.com/icons/png/512/3135/3135715.png'),
              ),
              accountName: Text(App.username),
              decoration:
                  BoxDecoration(color: Color.fromRGBO(242, 237, 215, 1)),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Color.fromRGBO(117, 81, 57, 1),
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: Color.fromRGBO(117, 81, 57, 1),
                ),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              leading: Icon(
                Icons.view_list,
                color: Color.fromRGBO(117, 81, 57, 1),
              ),
              title: Text(
                'Categories',
                style: TextStyle(
                  color: Color.fromRGBO(117, 81, 57, 1),
                ),
              ),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategorieScreen())),
            ),
            Divider(
              color: Color.fromRGBO(117, 81, 57, 1),
            ),
            Column(
              children: _categoryList,
            ),
            Divider(
              color: Color.fromRGBO(117, 81, 57, 1),
            ),
            ListTile(
              leading: Icon(
                Icons.subdirectory_arrow_left,
                color: Color.fromRGBO(117, 81, 57, 1),
              ),
              title: Text(
                'logout',
                style: TextStyle(
                  color: Color.fromRGBO(117, 81, 57, 1),
                ),
              ),
              onTap: () {
                App.loginState = 0;
                App.username = '';
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
