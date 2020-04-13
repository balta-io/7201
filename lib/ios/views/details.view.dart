import 'package:contacts/ios/views/address.view.dart';
import 'package:contacts/ios/styles.dart';
import 'package:contacts/ios/views/editor-contact.view.dart';
import 'package:contacts/ios/views/home.view.dart';
import 'package:contacts/ios/views/loading.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:contacts/shared/widgets/contact-details-description.widget.dart';
import 'package:contacts/shared/widgets/contact-details-image.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsView extends StatefulWidget {
  final int id;

  DetailsView({@required this.id});

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  final _repository = new ContactRepository();

  onDelete() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) {
        return new CupertinoAlertDialog(
          title: new Text("Exclusão de Contato"),
          content: new Text("Deseja excluir este contato?"),
          actions: <Widget>[
            CupertinoButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoButton(
              child: Text("Excluir"),
              onPressed: delete,
            )
          ],
        );
      },
    );
  }

  delete() {
    _repository.delete(widget.id).then((_) {
      onSuccess();
    }).catchError((err) {
      onError(err);
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
                  trailing: GestureDetector(
                    child: Icon(
                      CupertinoIcons.pen,
                    ),
                    onTap: () {
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
                      ContactDetailsImage(image: null),
                      SizedBox(
                        height: 10,
                      ),
                      ContactDetailsDescription(
                        name: contact.name,
                        phone: contact.phone,
                        email: contact.email,
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
                                    contact.addressLine1 ??
                                        "Nenhum endereço cadastrado",
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
                        height: 20,
                      ),
                      CupertinoButton.filled(
                        child: Text(
                          "Excluir Contato",
                        ),
                        onPressed: onDelete,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return LoadingView();
        }
      },
    );
  }
}
