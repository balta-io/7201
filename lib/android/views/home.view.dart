import 'package:contacts/android/views/editor-contact.view.dart';
import 'package:contacts/android/widgets/contact-list-item.widget.dart';
import 'package:contacts/android/widgets/search-appbar.widget.dart';
import 'package:contacts/controllers/home.controller.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: PreferredSize(
        child: SearchAppBar(
          controller: controller,
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Observer(
        builder: (_) => ListView.builder(
          itemCount: controller.contacts.length,
          itemBuilder: (ctx, i) {
            return ContactListItem(
              id: controller.contacts[i].id,
              image: controller.contacts[i].image,
              name: controller.contacts[i].name,
              phone: controller.contacts[i].phone,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditorContactView(
                model: new ContactModel(
                  id: 0,
                ),
              ),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
