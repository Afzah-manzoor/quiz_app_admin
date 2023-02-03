import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_admin/size_config.dart';

import '../../components/default_button.dart';
import '../../constants.dart';
import '../add quiz/add_quiz.dart';

class AddQuizDescription extends StatefulWidget {
  static String routeName = "/add_quiz_description";
  const AddQuizDescription({
    super.key,
    required this.category,
  });

  final String category;

  @override
  State<AddQuizDescription> createState() => _AddQuizDescriptionState();
}

class _AddQuizDescriptionState extends State<AddQuizDescription> {
  TextEditingController quizTitleCtrl = TextEditingController();
  TextEditingController totalMarksCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("Quiz Category::" + widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Quiz Description'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(children: <Widget>[
            const Text(
              'Enter Title',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(28)),
            buildFormField('Quiz Title', quizTitleCtrl),
            SizedBox(height: getProportionateScreenHeight(28)),
            buildFormField('Total Marks', totalMarksCtrl),
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(28.0),
        child: DefaultButton(
          press: () {
            if (quizTitleCtrl.text.isEmpty || totalMarksCtrl.text.isEmpty) {
              print("Please enter all details");
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Please enter all details!'),
              ));
            } else {
              createQuiz();
            }
          },
          text: 'Next',
        ),
      ),
    );
  }

  Future<void> createQuiz() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Quiz");

    var pushId = ref.push();

    await ref.child(pushId.key.toString()).set({
      "quizId": pushId.key.toString(),
      "category": widget.category,
      "quizTitle": quizTitleCtrl.text,
      "totalMarks": totalMarksCtrl.text
    }).then(
      (value) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddQuizScreen(
                category: widget.category,
                totalMarks: totalMarksCtrl.text,
                quizTitle: quizTitleCtrl.text,
                quizId: pushId.key.toString(),
              ),
            ));
      },
    );
  }

  TextFormField buildFormField(
      String labelText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter here';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: labelText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
      ),
    );
  }
}
