import 'package:contacts/android/views/details.view.dart';
import 'package:contacts/android/views/editor-contact.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: showSearch ? searchAppBar() : appBar(),
      body: FutureBuilder(
        future: _repository.search(term),
        builder: (ctx, snp) {
          if (snp.hasData) {
            List<ContactModel> items = snp.data;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, i) {
                return contactItem(
                  items[i],
                );
              },
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditorContactView(),
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

  Widget searchAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: TextField(
        onSubmitted: (val) {
          setState(() {
            term = val;
          });
        },
      ),
      centerTitle: true,
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            setState(() {
              term = "";
              showSearch = false;
            });
          },
          child: Icon(
            Icons.close,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text("Meus Contatos"),
      centerTitle: true,
      leading: FlatButton(
        onPressed: () {
          setState(() {
            term = "";
            showSearch = true;
          });
        },
        child: Icon(
          Icons.search,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget contactItem(ContactModel model) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48),
          image: DecorationImage(
            image: NetworkImage(model.image),
          ),
        ),
      ),
      title: Text(model.name),
      subtitle: Text(model.phone),
      trailing: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsView(
                id: model.id,
              ),
            ),
          );
        },
        child: Icon(
          Icons.person,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
