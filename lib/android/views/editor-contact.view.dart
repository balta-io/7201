import 'package:contacts/android/views/home.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: (widget.model.name == "")
            ? Text("Novo Contato")
            : Text("Editar Contato"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Nome",
                ),
                initialValue: widget.model?.name,
                onChanged: (val) {
                  widget.model.name = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Telefone",
                ),
                initialValue: widget.model?.phone,
                onChanged: (val) {
                  widget.model.phone = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "E-mail",
                ),
                initialValue: widget.model?.email,
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
                child: FlatButton.icon(
                  color: Theme.of(context).primaryColor,
                  onPressed: handleSubmit,
                  icon: Icon(
                    Icons.save,
                    color: Theme.of(context).accentColor,
                  ),
                  label: Text(
                    "Salvar",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
