import 'package:contacts/ios/views/home.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:flutter/cupertino.dart';

class EditorContactView extends StatefulWidget {
  final ContactModel model;

  EditorContactView({this.model});

  @override
  _EditorContactViewState createState() => _EditorContactViewState();
}

class _EditorContactViewState extends State<EditorContactView> {
  final _formKey = GlobalKey<FormState>();
  final _repository = ContactRepository();

  onSubmit() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    if (widget.model.id == 0)
      create();
    else
      update();
  }

  create() async {
    widget.model.id = null;
    widget.model.image = null;

    _repository.create(widget.model).then((_) {
      onSuccess();
    }).catchError((_) {
      onError();
    });
  }

  update() {
    _repository.update(widget.model).then((_) {
      onSuccess();
    }).catchError((_) {
      onError();
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

  onError() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) {
        return new CupertinoAlertDialog(
          title: new Text("Falha na operação"),
          content: new Text("Ops, parece que algo deu errado"),
          actions: <Widget>[
            CupertinoButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: widget.model.id == 0
                ? Text("Novo Contato")
                : Text("Editar Contato"),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CupertinoTextField(
                      placeholder: widget.model?.name ?? "Nome",
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      onChanged: (val) {
                        widget.model.name = val;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CupertinoTextField(
                      placeholder: widget.model?.phone ?? "Telefone",
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        widget.model.phone = val;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CupertinoTextField(
                      placeholder: widget.model?.email ?? "E-mail",
                      keyboardType: TextInputType.emailAddress,
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
                        onPressed: onSubmit,
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
