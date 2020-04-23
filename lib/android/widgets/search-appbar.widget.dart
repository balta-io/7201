import 'package:contacts/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SearchAppBar extends StatelessWidget {
  final HomeController controller;

  SearchAppBar({
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Observer(
        builder: (_) => controller.showSearch
            ? TextField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Pesquisar...",
                ),
                onSubmitted: (val) {
                  controller.search(val);
                },
              )
            : Text("Meus Contato"),
      ),
      centerTitle: true,
      leading: FlatButton(
        onPressed: () {
          if (controller.showSearch) controller.search("");
          controller.toggleSearch();
        },
        child: Observer(
          builder: (_) => Icon(
            controller.showSearch ? Icons.close : Icons.search,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
