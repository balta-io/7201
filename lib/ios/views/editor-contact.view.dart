import 'package:contacts/ios/views/home.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:flutter/cupertino.dart';

class EditorContactView extends StatefulWidget {
  ContactModel model;

  EditorContactView({this.model});

  @override
  _EditorContactViewState createState() => _EditorContactViewState();
}

class _EditorContactViewState extends State<EditorContactView> {
  final ContactRepository _repository = new ContactRepository();

  @override
  void initState() {
    super.initState();
    if (widget.model == null) widget.model = new ContactModel();
  }

  handleSubmit() {
    if (widget.model.id == null) {
      widget.model.image = "https://placehold.it/200";

      _repository.create(widget.model).then((_) {
        onSuccess();
      }).catchError((err) {
        onError(err);
      }).whenComplete(() {
        // TODO: Fazer algo legal
      });
    } else {
      _repository.update(widget.model).then((_) {
        onSuccess();
      }).catchError((err) {
        onError(err);
      }).whenComplete(() {
        // TODO: Fazer algo legal
      });
    }
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
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: (widget.model.name == "")
                ? Text("Novo Contato")
                : Text("Editar Contato"),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                child: Column(
                  children: <Widget>[
                    CupertinoTextField(
                      placeholder: widget.model?.name ?? "Nome",
                      onChanged: (val) {
                        widget.model.name = val;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CupertinoTextField(
                      placeholder: widget.model?.phone ?? "Telefone",
                      onChanged: (val) {
                        widget.model.phone = val;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CupertinoTextField(
                      placeholder: widget.model?.email ?? "E-mail",
                      onChanged: (val) {
                        widget.model.email = val;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: CupertinoButton.filled(
                        onPressed: handleSubmit,
                        child: Text(
                          "Salvar",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
