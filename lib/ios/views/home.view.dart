import 'package:contacts/controllers/home.controller.dart';
import 'package:contacts/ios/styles.dart';
import 'package:contacts/ios/views/details.view.dart';
import 'package:contacts/ios/widgets/contact-list-item.widget.dart';
import 'package:contacts/ios/widgets/search-appbar.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    controller.search("");
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: SearchAppBar(
        controller: controller,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Observer(
          builder: (_) => ListView.builder(
            itemCount: controller.contacts.length,
            itemBuilder: (ctx, i) {
              return ContactListItem(
                model: controller.contacts[i],
              );
            },
          ),
        ),
      ),
    );
  }
}
