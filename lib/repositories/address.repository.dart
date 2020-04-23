import 'package:dio/dio.dart';

class AddressRepository {
  String url =
      "https://maps.googleapis.com/maps/api/geocode/json?key=SUA-CHAVE&address=";

  Future<dynamic> searchAdress(String address) async {
    Response response = await Dio().get(url + address);

    String city =
        response.data["results"][0]["address_components"][0]["long_name"];
    String adrs = response.data["results"][0]["formatted_address"];
    double poslat = response.data["results"][0]["geometry"]["location"]["lat"];
    double poslong = response.data["results"][0]["geometry"]["location"]["lng"];

    return {
      'addressLine1': adrs,
      'addressLine2': city,
      'lat': poslat,
      'long': poslong,
    };
  }
}
