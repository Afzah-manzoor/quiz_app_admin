import 'package:flutter/material.dart';

import '../../size_config.dart';
import '../quizDescription/quiz_description.dart';

class QuizCategory extends StatefulWidget {
  static String routeName = "/category";
  const QuizCategory({super.key});

  @override
  State<QuizCategory> createState() => _QuizCategoryState();
}

class _QuizCategoryState extends State<QuizCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(children: <Widget>[
            const Text(
              'Choose a Category',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddQuizDescription(
                              category: 'Mobile App Development',
                            )));
              },
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ListTile(
                  title: Text(
                    'Mobile App Development',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  leading: Icon(Icons.mobile_off),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddQuizDescription(category: 'Web Development')));
              },
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ListTile(
                  title: Text(
                    'Web Development',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  leading: Icon(Icons.mobile_off),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddQuizDescription(category: 'E-Commerce')));
              },
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ListTile(
                  title: Text(
                    'E-Commerce',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  leading: Icon(Icons.mobile_off),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddQuizDescription(category: 'Digital Marketing')));
              },
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ListTile(
                  title: Text(
                    'Digital Marketing',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  leading: Icon(Icons.mobile_off),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddQuizDescription(category: 'Cyber Security')));
              },
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ListTile(
                  title: Text(
                    'Cyber Security',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  leading: Icon(Icons.mobile_off),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
          ]),
        ),
      ),
    );
  }
}
