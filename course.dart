

class Course{
  int id;
  String title;
  String description;
  String descriptionFull;
  List<String> lessons;

  Course({
    required this.id, required this.title,
    this.description = 'описание курса',
    this.descriptionFull = 'полное описание курса',
    this.lessons = const ['урок 1', 'урок 2']});
}


