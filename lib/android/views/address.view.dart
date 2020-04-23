import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/address.repository.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class AddressView extends StatefulWidget {
  final ContactModel model;

  AddressView({this.model});

  @override
  _AddressViewState createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  final AddressRepository _addressRepository = AddressRepository();
  final ContactRepository _contactRepository = ContactRepository();

  Set<Marker> markers = new Set<Marker>();
  GoogleMapController mapController;
  LatLng _center = const LatLng(45.521563, -122.677433);

  @override
  void initState() {
    super.initState();
    if (widget.model.latLng != null && widget.model.latLng != "") {
      var values = widget.model.latLng.split(',');
      _center = LatLng(
        double.parse(values[0]),
        double.parse(values[1]),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setMapPosition(widget.model.addressLine2, widget.model.addressLine1);
  }

  onSearch(address) {
    _addressRepository.searchAdress(address).then((data) {
      _center = LatLng(
        data['lat'],
        data['long'],
      );

      widget.model.addressLine1 = data['addressLine1'];
      widget.model.addressLine2 = data['addressLine2'];
      widget.model.latLng = "${data['lat']},${data['long']}";

      setMapPosition(data['addressLine2'], data['addressLine1']);
    }).catchError((err) {
      print(err);
    });
  }

  setCurrentLocation() async {
    Position position = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _center = LatLng(
      position.latitude,
      position.longitude,
    );

    setMapPosition("balta.io", "Posição Atual");
  }

  setMapPosition(title, snippet) {
    mapController.animateCamera(CameraUpdate.newLatLng(_center));
    markers = Set<Marker>();

    final uuid = Uuid();
    Marker marker = Marker(
      markerId: MarkerId('${uuid.v4()}'),
      position: _center,
      infoWindow: InfoWindow(
        title: title,
        snippet: snippet,
      ),
    );

    markers.add(marker);
    setState(() {});
  }

  updateContactInfo() {
    _contactRepository
        .updateAddress(
      widget.model.id,
      widget.model.addressLine1,
      widget.model.addressLine2,
      widget.model.latLng,
    )
        .then((_) {
      onSuccess();
    }).catchError((_) {
      onError();
    });
  }

  onSuccess() {
    Navigator.pop(context);
  }

  onError() {
    // Exibir snackbar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Endereço do Contato"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.save),
            onPressed: updateContactInfo,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 80,
            child: ListTile(
              title: Text(
                "Endereço atual",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.model.addressLine1 ?? "",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    widget.model.addressLine2 ?? "",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              isThreeLine: true,
            ),
          ),
          Container(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Pesquisar...",
                ),
                onSubmitted: (val) {
                  onSearch(val);
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                markers: markers,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: setCurrentLocation,
        child: Icon(Icons.my_location),
      ),
    );
  }
}
