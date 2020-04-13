import 'package:flutter/cupertino.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
