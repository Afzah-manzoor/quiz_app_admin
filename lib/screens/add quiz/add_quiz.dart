import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../components/default_button.dart';
import '../../constants.dart';
import '../../helper/keyboard.dart';
import '../../models/question_model.dart';
import '../../size_config.dart';

class AddQuizScreen extends StatefulWidget {
  static String routeName = "/add_quiz";
  const AddQuizScreen({
    super.key,
    required this.category,
    required this.totalMarks,
    required this.quizTitle,
    required this.quizId,
  });
  final String category, totalMarks, quizTitle, quizId;

  @override
  State<AddQuizScreen> createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  TextEditingController questionCtrl = TextEditingController();
  TextEditingController option1Ctrl = TextEditingController();
  TextEditingController option2Ctrl = TextEditingController();
  TextEditingController option3Ctrl = TextEditingController();
  TextEditingController option4Ctrl = TextEditingController();
  TextEditingController marksCtrl = TextEditingController();

  int currentPage = 0;
  PageController? _pageController;
  final _formKey = GlobalKey<FormState>();
  var _options = [
    "option1",
    "option2",
    "option3",
    "option4",
  ];
  String _currentSelectedValue = 'option1';

  @override
  void initState() {
    _pageController = PageController(initialPage: currentPage);
    super.initState();

    print("QUIZ DETAILS");
    print("Cateogory" + widget.category);
    print("totalMarks" + widget.totalMarks);
    print("quizTitle" + widget.quizTitle);
    print("QUIZID" + widget.quizId);
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: 1,
                itemBuilder: (context, index) => SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Enter Quiz Title',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        SizedBox(height: getProportionateScreenHeight(16)),
                        const Text(
                          'Question',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        buildFormField("Question", questionCtrl),
                        SizedBox(height: getProportionateScreenHeight(16)),
                        const Text(
                          'Marks',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        buildFormField("Marks", marksCtrl),
                        SizedBox(height: getProportionateScreenHeight(16)),
                        const Text(
                          'Options',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        buildFormField("Option 1", option1Ctrl),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        buildFormField("Option 2", option2Ctrl),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        buildFormField("Option 3", option3Ctrl),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        buildFormField("Option 4", option4Ctrl),
                        SizedBox(height: getProportionateScreenHeight(16)),
                        const Text(
                          'Correct Option',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        buildOptionsFormFiels(),
                        SizedBox(height: getProportionateScreenHeight(32)),
                      ]),
                ),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(28.0),
        child: DefaultButton(
          press: () {
            addQuestion();
          },
          text: "Next",
        ),
      ),
    );
  }

  Future<void> addQuestion() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      KeyboardUtil.hideKeyboard(context);
      DatabaseReference ref = FirebaseDatabase.instance
          .ref("Quiz")
          .child(widget.quizId)
          .child('Questions');

      var pushId = ref.push();

      QuestionModel quizModel = QuestionModel.withId(
          pushId.key.toString(),
          questionCtrl.text,
          option1Ctrl.text,
          option2Ctrl.text,
          option3Ctrl.text,
          option4Ctrl.text,
          marksCtrl.text,
          _currentSelectedValue);

      await ref.child(pushId.key.toString()).update(quizModel.toJson()).then(
        (value) {
          questionCtrl.text = '';
          option1Ctrl.text = '';
          option2Ctrl.text = '';
          option3Ctrl.text = '';
          option4Ctrl.text = '';
          marksCtrl.text = '';
          _currentSelectedValue = 'option1';
        },
      );
    }
  }

  FormField buildOptionsFormFiels() {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
              hintText: 'Choose an Option',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _currentSelectedValue,
              onChanged: (String? newValue) {
                setState(() {
                  _currentSelectedValue = newValue!;
                  state.didChange(newValue);
                });
              },
              items: _options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
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
