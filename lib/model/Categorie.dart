class Categorie{
  int id;
  String name;
  String description;

  @override
  String toString() {
    return 'Categorie{name: $name, description: $description}';
  }
  categorieMap(){
    var mapping=Map<String,dynamic>();
    mapping['id']=id;
    mapping['name']=name;
    mapping['description']=description;
    return mapping;
  }

}