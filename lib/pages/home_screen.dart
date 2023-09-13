import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
  
  final formKey = GlobalKey<FormBuilderState>();
  final uNameController = TextEditingController();
  final pswController = TextEditingController();

  void resetValues() {
    setState(() {
      uNameController.text = "";
      pswController.text = "";
    });
  }

  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      elevation: 0,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home_filled,
              color: Colors.white,
            ),
            Text(
              'Home',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      body: Center(
        child: FormBuilder(
          key: formKey,
          child: Column(children: [
            Container(
              padding: 
                const EdgeInsets.only(
                  top: 10, 
                  left: 10, 
                  right: 10
                ),
              child: FormBuilderTextField(
                name: "uname",
                decoration: const InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      width: 4,
                      color: Colors.red
                    )
                  )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'username cannot be empty!';
                  }
                  return null;
                }
              ),
            ),
            Text(uNameController.text),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FormBuilderTextField(
                name: "psw",
                decoration: const InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      width: 4,
                      color: Colors.red
                      )
                    )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'username cannot be empty!';
                    }
                    return null;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10, 
                bottom: 10
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.white,
                ),
                onPressed: () {
                  if (formKey.currentState!.saveAndValidate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 2),
                        content: Row(
                          children: [
                            Text("Logging in....")
                          ],
                        )
                      ),
                    );
                    resetValues();
                  }
                },
                child: const Text('Login'),
              ),
            ),
          ]),
        ),
      )
    );
  }
}
