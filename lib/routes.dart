import 'package:flutter/widgets.dart';

import 'Screens/home/home_screen.dart';
import 'Screens/login/login_screen.dart';
import 'Screens/splash/splash_screen.dart';
import 'screens/add quiz/add_quiz.dart';
import 'screens/quizDescription/quiz_description.dart';
import 'screens/quiz_category/quiz_category.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  QuizCategory.routeName: (context) => const QuizCategory(),
  AddQuizScreen.routeName: (context) => const AddQuizScreen(
        category: '',
        quizTitle: '',
        totalMarks: '',
        quizId: '',
      ),
  AddQuizDescription.routeName: (context) =>
      const AddQuizDescription(category: ''),
};
