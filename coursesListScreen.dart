import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'courseWidget.dart';
import 'course.dart';
import 'statemanagement.dart'; 
import 'getFromDB.dart';

class CourseListPage extends ConsumerStatefulWidget {
  const CourseListPage({super.key});

  @override
  ConsumerState<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends ConsumerState<CourseListPage> {
  List<Course> courses = [];
  bool _loading = true;
  bool _showFavoritesOnly = false; 

  Future<void> _getConnBD() async {
    courses = await CourseService.getCourses();
    setState(() {
      _loading = false; 
    });
  }

  @override
  void initState() {
    super.initState();
    _getConnBD();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteIds = ref.watch(favoritesProvider);
    final filteredCourses = _showFavoritesOnly 
        ? courses.where((course) => favoriteIds.contains(course.id)).toList()
        : courses;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black87,
            Color.fromARGB(255, 0, 20, 50),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text(
            "Список курсов",
            style: TextStyle(
              color: Colors.lightBlue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                _showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
                color: _showFavoritesOnly ? Colors.red : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _showFavoritesOnly = !_showFavoritesOnly; 
                });
              },
            ),
          ],
        ),
        body: Center(
          child: _loading 
            ? const CircularProgressIndicator(
                color: Colors.lightBlueAccent,
                strokeWidth: 10,
              ) 
            : filteredCourses.isEmpty 
                ? const Text(
                    "Нет курсов для отображения",
                    style: TextStyle(color: Colors.white),
                  )
                : ListView.builder(
                    itemCount: filteredCourses.length,
                    itemBuilder: (context, index) {
                      return CourseWidget(course: filteredCourses[index]);
                    },
                  ),
        ),
      ),
    );
  }
}
