class Todo{
  int id;
  String title;
  String description;
  String category;
  String date;
  int finiched;

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, description: $description, category: $category, date: $date, finiched: $finiched}';
  }

  toDoMap(){
    var mapping=Map<String,dynamic>();
    mapping['id']=id;
    mapping['title']=title;
    mapping['description']=description;
    mapping['category']=category;
    mapping['date']=date;
    mapping['finiched']=finiched;
    return mapping;
  }
}