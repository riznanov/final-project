import 'vendor.dart';

class VendorList {
  List<Vendor> records = new List();

  VendorList({
    this.records
  });

  factory VendorList.fromJson(List<dynamic> parsedJson) {

    List<Vendor> records = new List<Vendor>();

    records = parsedJson.map((i) => Vendor.fromJson(i)).toList();

    return new VendorList(
      records: records,
    );
  }
}