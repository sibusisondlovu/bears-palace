class Service {
  String id;
  String serviceName;
  String fee;

  Service({this.id, this.serviceName, this.fee});

  factory Service.fromJson(Map<String, dynamic> parsedJson) {
    return Service(
      id: parsedJson["id"],
      serviceName: parsedJson["serviceName"] as String,
      fee: parsedJson["fee"]
    );
  }
}