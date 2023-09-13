import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const SizedBox(height: 13,),
        const Text(
          "Contact Us",
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10,),
        const SizedBox(
          height: 60,
          width: 400,
          child: Text(
              "Any ideas, any problems, collaboration, any meeting request? Contact us!"),
        ),
        const SizedBox(
            width: 400,
            child: TextField(
              minLines: 8,
              maxLines: 12,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      "Any ideas, any problems, collaboration, any meeting request? Contact us!"),
            )),
            Padding(padding: EdgeInsets.only(top: 10), child: 
            ElevatedButton(onPressed: (){}, child: const Text("Submit")))
      ],
    );
  }
}
