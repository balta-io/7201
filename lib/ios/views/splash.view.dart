import 'package:contacts/controllers/auth.controoler.dart';
import 'package:contacts/ios/styles.dart';
import 'package:contacts/ios/views/home.view.dart';
import 'package:flutter/cupertino.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final controller = new AuthController();

  @override
  void initState() {
    super.initState();
    controller.authenticate().then((_) {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => HomeView(),
        ),
      );
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: primaryColor,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
            ),
            Icon(
              CupertinoIcons.padlock,
              size: 72,
              color: accentColor,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Meus Contatos",
              style: TextStyle(
                fontSize: 24,
                color: accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
