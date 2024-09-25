import 'package:postgres/postgres.dart';
import 'course.dart'; 

// Future<Connection> connectToSQL() async {
//   return await Connection.open(
//     Endpoint(
//       host: 'localhost',
//       database: 'dormitory',
//       username: 'flutterist',
//       password: 'Opti',
      
//     ),
//     settings: ConnectionSettings(sslMode: SslMode.disable),
//   );
// }

class CourseService {
  static late Connection connection;

  static Future<List<Course>> getCourses() async {
    List<Course> courses = [];

    try {
      // Подключаемся к базе данных
      connection = await Connection.open(
        Endpoint(
          host: 'localhost',
          database: 'courses',
          username: 'flutterist',
          password: 'Opti',
          
        ),
        settings: ConnectionSettings(sslMode: SslMode.disable),
      );

      List<List<dynamic>> results = await connection.execute(
        'SELECT id, title, description, description_full, lessons FROM courses'
      );

      for (var row in results) {
        courses.add(
          Course(
            id: row[0],
            title: row[1],
            description: row[2],
            descriptionFull: row[3], 
            lessons: List<String>.from(row[4])
          ),
        );
      }
    } catch (e) {
      print("Ошибка получения курсов: $e");
    } finally {
      await connection.close(); 
    }
    return courses;
  }
}