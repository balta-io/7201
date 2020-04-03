import 'package:contacts/ios/views/editor-contact.view.dart';
import 'package:contacts/ios/styles.dart';
import 'package:contacts/ios/views/details.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:flutter/cupertino.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String term = "";
  bool showSearch = false;
  final ContactRepository _repository = new ContactRepository();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: showSearch ? searchNavigationBar() : navigationBar(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _repository.search(term),
          builder: (ctx, snp) {
            if (snp.hasData) {
              List<ContactModel> items = snp.data;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (ctx, i) {
                  return contactItem(
                    context,
                    items[i],
                  );
                },
              );
            } else {
              return Container(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget navigationBar() {
    return CupertinoNavigationBar(
      middle: Text("Meus Contatos"),
      leading: CupertinoButton(
        child: Icon(
          CupertinoIcons.search,
        ),
        onPressed: () {
          setState(() {
            term = "";
            showSearch = true;
          });
        },
      ),
      trailing: CupertinoButton(
        child: Icon(
          CupertinoIcons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => EditorContactView(),
            ),
          );
        },
      ),
    );
  }

  Widget searchNavigationBar() {
    return CupertinoNavigationBar(
      middle: CupertinoTextField(
        placeholder: "Pesquisar...",
        onSubmitted: (val) {
          setState(() {
            term = val;
          });
        },
      ),
      trailing: CupertinoButton(
        child: Icon(
          CupertinoIcons.clear,
        ),
        onPressed: () {
          setState(() {
            term = "";
            showSearch = false;
          });
        },
      ),
    );
  }

  Widget contactItem(context, ContactModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(model.image),
            ),
            borderRadius: BorderRadius.circular(48),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.name,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  model.phone,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        CupertinoButton(
          child: Icon(
            CupertinoIcons.person,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => DetailsView(id: model.id),
              ),
            );
          },
        ),
      ],
    );
  }
}
