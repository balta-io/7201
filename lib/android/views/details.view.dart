import 'package:contacts/android/styles.dart';
import 'package:contacts/android/views/address.view.dart';
import 'package:contacts/android/views/editor-contact.view.dart';
import 'package:contacts/android/views/home.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsView extends StatefulWidget {
  final int id;

  DetailsView({@required this.id});

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  final ContactRepository _repository = new ContactRepository();

  handleDelete() {
    showDialog(
      context: context,
      builder: (ctx) {
        return new AlertDialog(
          title: new Text("Exclusão de Contato"),
          content: new Text("Deseja excluir este contato?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Excluir"),
              onPressed: doDelete,
            )
          ],
        );
      },
    );
  }

  doDelete() {
    _repository.delete(widget.id).then((_) {
      onSuccess();
    }).catchError((err) {
      onError(err);
    }).whenComplete(() {
      // TODO: Fazer algo legal
    });
  }

  onSuccess() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeView(),
      ),
    );
  }

  onError(err) {
    print(err);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _repository.getContact(widget.id),
      builder: (ctx, snp) {
        ContactModel contact = snp.data;

        if (snp.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Contato"),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                  width: double.infinity,
                ),
                Container(
                  width: 200,
                  height: 200,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: NetworkImage(contact.image),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  contact.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  contact.phone,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  contact.email,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        launch("tel://${contact.phone}");
                      },
                      color: Theme.of(context).primaryColor,
                      shape: CircleBorder(
                        side: BorderSide.none,
                      ),
                      child: Icon(
                        Icons.phone,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        launch("mailto://${contact.email}");
                      },
                      color: Theme.of(context).primaryColor,
                      shape: CircleBorder(
                        side: BorderSide.none,
                      ),
                      child: Icon(
                        Icons.email,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
                      color: Theme.of(context).primaryColor,
                      shape: CircleBorder(
                        side: BorderSide.none,
                      ),
                      child: Icon(
                        Icons.camera_enhance,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                ListTile(
                  title: Text(
                    "Endereço",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        contact.addressLine1 ?? "Nenhum endereço definido",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        contact.addressLine2 ?? "",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddressView(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.pin_drop,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: FlatButton(
                      color: Colors.red,
                      child: Text(
                        "Excluir Contato",
                        style: TextStyle(
                          color: accentColor,
                        ),
                      ),
                      onPressed: handleDelete,
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditorContactView(
                      model: contact,
                    ),
                  ),
                );
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.edit,
                color: Theme.of(context).accentColor,
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
