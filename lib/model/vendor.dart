class Vendor{
  String name;
  String subname;
  String address;
  String contact;

  Vendor({
    this.name,this.subname,this.address,this.contact
  });

 factory Vendor.fromJson(Map<String, dynamic> json){
    return new Vendor(
        name: json['name'],
        subname: json['subname'],
        address: json ['address'],
        contact: json['contact'],
    );
  }
}