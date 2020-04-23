import 'package:contacts/controllers/home.controller.dart';
import 'package:contacts/ios/views/editor-contact.view.dart';
import 'package:contacts/ios/widgets/contact-list-item.widget.dart';
import 'package:contacts/models/contact.model.dart';
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
      navigationBar: searchAppBar(controller),
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

  Widget searchAppBar(controller) {
    return CupertinoNavigationBar(
      middle: Observer(
        builder: (_) => controller.showSearch
            ? CupertinoTextField(
                autofocus: true,
                placeholder: "Pesquisar...",
                onSubmitted: (val) {
                  controller.search(val);
                },
              )
            : Text("Meus Contatos"),
      ),
      leading: GestureDetector(
        onTap: () {
          if (controller.showSearch) controller.search("");
          controller.toggleSearch();
        },
        child: Observer(
          builder: (_) => Icon(
            controller.showSearch
                ? CupertinoIcons.clear
                : CupertinoIcons.search,
          ),
        ),
      ),
      trailing: GestureDetector(
        child: Icon(
          CupertinoIcons.add,
        ),
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => EditorContactView(
                model: ContactModel(
                  id: 0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
