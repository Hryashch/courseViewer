import 'package:flutter/material.dart';
import 'courseDetailsScreen.dart';
import 'course.dart';
import 'statemanagement.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class CourseWidget extends ConsumerWidget {

  CourseWidget({super.key, required this.course});
  
  Course course;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isFavorite = ref.watch(favoritesProvider).contains(course.id);


    return Card(
      color: Colors.black54,
      shadowColor: Colors.blueGrey,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.lightBlue,
        onTap: () {
          Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => CourseDaetailsPage(course: this.course))
          );
        },
        child: 
          ListTile(
            leading: const Icon(Icons.school),
            title: Text(
              course.title,
              style: const TextStyle(color: Colors.lightBlue),
              ),
            subtitle: Text(
              course.description,
              // style: TextStyle(color: Colors.lightBlue.shade900),
              ),
            trailing: IconButton(
              icon: !isFavorite ? const Icon(Icons.favorite_border_outlined)
                            : const Icon(Icons.favorite, color: Colors.red, ),                
              onPressed: (){
                ref.read(favoritesProvider.notifier).toggleFavorite(course.id);
              }, 
            ),
          ),
      )
    );
  }
}