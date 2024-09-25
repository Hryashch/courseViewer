import 'package:courseviewer/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'statemanagement.dart';

class CourseDaetailsPage extends ConsumerWidget {

  Course course;
  CourseDaetailsPage({required this.course});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final isFavorite = ref.watch(favoritesProvider).contains(course.id);


    return Container(
      
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.black87,
          Color.fromARGB(255, 0, 20, 50),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        )   
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title:   Text(course.title,
            style: const TextStyle(
              color:  Colors.lightBlue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              ),
            ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.lightBlueAccent,  
            ),
            onPressed: () {
              Navigator.pop(context);
            }
          ),
          actions: [
            IconButton(
              icon: !isFavorite ? const Icon(Icons.favorite_border_outlined, color: Colors.lightBlueAccent)
                              : const Icon(Icons.favorite, color: Colors.red, ),
              onPressed: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(course.id);
              }
            ),
          ],
        ),
        body: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(course.descriptionFull),
                const SizedBox(height: 30, width: 1000,),
                Text('Количество уроков: ${course.lessons.length}'),
                Expanded(
                  child: ListView(
                    children: List.generate(
                      course.lessons.length,
                      (index) => Text('- ${course.lessons[index]}'),
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}