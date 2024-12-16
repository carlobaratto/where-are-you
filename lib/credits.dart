import 'package:flutter/cupertino.dart';

class credits extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'WhereAreYou is a ',
        style: DefaultTextStyle.of(context).style,
        children: const <TextSpan>[
          TextSpan(text: 'free/libre ', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          TextSpan(text: 'application for share your location without give your personal data away!'),
          TextSpan(text: '\n'),
          TextSpan(text: 'Thanks to Lorenzo Caraffini for the great development job'),
          TextSpan(text: 'and ILS Este for testing the application'),
          TextSpan(text: '\n'),
          TextSpan(text: 'Feel fre to copy, share and improve the codebase!'),
        ],
      ),
    );
  }
}
