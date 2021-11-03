import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:showcase/Logic/EmailLogic.dart';
import 'package:showcase/Models/Email.dart';

import 'WelcomeText.dart';

class EmailForm extends StatefulWidget {
  final BoolCallback onChange;
  const EmailForm({Key? key, required this.onChange}) : super(key: key);

  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController bodyTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool animate = false;

  @override
  void dispose() {
    emailTextController.dispose();
    bodyTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EmailLogic logic = EmailLogic();
    Future<LottieComposition> animationComposite = logic.fetchAnimation();

    TextFormField emailField = TextFormField(
      controller: emailTextController,
      maxLength: 50,
      expands: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email_sharp),
        border: UnderlineInputBorder(),
        labelText: 'Enter your email address',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter you email address';
        } else if (!EmailValidator.validate(value)) {
          return 'Please ensure your email is valid';
        }
        return null;
      },
    );

    TextFormField textBodyField = TextFormField(
      controller: bodyTextController,
      maxLength: 500,
      minLines: 10,
      maxLines: 40,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.textsms),
        border: UnderlineInputBorder(),
        labelText: 'Please enter your message',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        } else if (value.toLowerCase() == 'Easter-Egg'.toLowerCase()) {
          //Activate the game easter egg
          this.widget.onChange(true);
        }
        return null;
      },
    );

    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: emailField,
          ),
          Padding(padding: const EdgeInsets.all(10.0), child: textBodyField),
          ButtonBar(
            children: [
              ElevatedButton(
                onPressed: () {
                  emailTextController.clear();
                  bodyTextController.clear();
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Row(
                        children: [
                          Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Sending Email!'),
                          ),
                        ],
                      )),
                    );
                    setState(() {
                      animate = true;
                    });
                    Email email = Email(
                        emailTextController.text,
                        bodyTextController.text,
                        DateTime.now().toLocal().toIso8601String());
                    emailTextController.clear();
                    bodyTextController.clear();
                    logic.sendEmail(email);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
          FutureBuilder<LottieComposition>(
              future: animationComposite,
              builder: (context, snapshot) {
                if (snapshot.hasData && animate) {
                  var screenSize = MediaQuery.of(context).size;
                  return SizedBox(
                      width: screenSize.width - 20.0,
                      height: screenSize.height / 11,
                      child: Lottie(composition: snapshot.data, repeat: false));
                }
                return Container();
              })
        ],
      ),
    );
  }
}
