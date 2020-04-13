// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeController, Store {
  final _$showSearchAtom = Atom(name: '_HomeController.showSearch');

  @override
  bool get showSearch {
    _$showSearchAtom.context.enforceReadPolicy(_$showSearchAtom);
    _$showSearchAtom.reportObserved();
    return super.showSearch;
  }

  @override
  set showSearch(bool value) {
    _$showSearchAtom.context.conditionallyRunInAction(() {
      super.showSearch = value;
      _$showSearchAtom.reportChanged();
    }, _$showSearchAtom, name: '${_$showSearchAtom.name}_set');
  }

  final _$contactsAtom = Atom(name: '_HomeController.contacts');

  @override
  ObservableList<ContactModel> get contacts {
    _$contactsAtom.context.enforceReadPolicy(_$contactsAtom);
    _$contactsAtom.reportObserved();
    return super.contacts;
  }

  @override
  set contacts(ObservableList<ContactModel> value) {
    _$contactsAtom.context.conditionallyRunInAction(() {
      super.contacts = value;
      _$contactsAtom.reportChanged();
    }, _$contactsAtom, name: '${_$contactsAtom.name}_set');
  }

  final _$searchAsyncAction = AsyncAction('search');

  @override
  Future search(String term) {
    return _$searchAsyncAction.run(() => super.search(term));
  }

  final _$_HomeControllerActionController =
      ActionController(name: '_HomeController');

  @override
  dynamic toggleSearch() {
    final _$actionInfo = _$_HomeControllerActionController.startAction();
    try {
      return super.toggleSearch();
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'showSearch: ${showSearch.toString()},contacts: ${contacts.toString()}';
    return '{$string}';
  }
}
