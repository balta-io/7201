import 'package:flutter/widgets.dart';

class ContactDetailsDescription extends StatelessWidget {
  final String name;
  final String phone;
  final String email;

  ContactDetailsDescription({
    @required this.name,
    @required this.phone,
    @required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          phone,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          email,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
