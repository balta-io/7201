import 'package:contacts/ios/views/address.view.dart';
import 'package:contacts/ios/styles.dart';
import 'package:contacts/ios/views/editor-contact.view.dart';
import 'package:contacts/ios/views/home.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:flutter/cupertino.dart';
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
    showCupertinoDialog(
      context: context,
      builder: (ctx) {
        return new CupertinoAlertDialog(
          title: new Text("Exclusão de Contato"),
          content: new Text("Deseja excluir este contato?"),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text("Excluir"),
              isDestructiveAction: true,
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
      CupertinoPageRoute(
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
        if (snp.hasData) {
          ContactModel contact = snp.data;

          return CupertinoPageScaffold(
            child: CustomScrollView(
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  largeTitle: Text("Contato"),
                  trailing: CupertinoButton(
                    child: Icon(
                      CupertinoIcons.pen,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => EditorContactView(
                            model: contact,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SliverFillRemaining(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                        width: double.infinity,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(contact.image),
                            ),
                            borderRadius: BorderRadius.circular(100),
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
                          CupertinoButton(
                            onPressed: () {
                              launch("tel://${contact.phone}");
                            },
                            child: Icon(
                              CupertinoIcons.phone,
                            ),
                          ),
                          CupertinoButton(
                            onPressed: () {
                              launch("mailto://${contact.email}");
                            },
                            child: Icon(
                              CupertinoIcons.mail,
                            ),
                          ),
                          CupertinoButton(
                            onPressed: () {},
                            child: Icon(
                              CupertinoIcons.photo_camera,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: double.infinity,
                                  ),
                                  Text(
                                    "Endereço",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "Rua do Desenvolvedor, 256",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "Piracicaba/SP",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => AddressView(),
                                  ),
                                );
                              },
                              child: Icon(
                                CupertinoIcons.location,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      CupertinoButton(
                        child: Text(
                          "Excluir Contato",
                          style: TextStyle(
                            color: Color(0xFFFF0000),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPressed: handleDelete,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return CupertinoPageScaffold(
            child: Container(
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
