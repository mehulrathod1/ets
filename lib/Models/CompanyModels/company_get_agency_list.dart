class Item {
  String id;
  String name;

  Item({
    required this.id,
    required this.name,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Data {
  List<Item> list;

  Data({required this.list});

  factory Data.fromJson(Map<String, dynamic> json) {
    List<dynamic> items = json['List'];
    List<Item> itemList = items.map((item) => Item.fromJson(item)).toList();
    return Data(list: itemList);
  }
}

class CompanyGetAgencyList {
  String status;
  String message;
  Data data;

  CompanyGetAgencyList({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyGetAgencyList.fromJson(Map<String, dynamic> json) {
    return CompanyGetAgencyList(
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

// void main() {
//   String jsonStr = '''{
//     // your JSON data here
//   }''';
//
//   Map<String, dynamic> jsonMap = json.decode(jsonStr);
//   CompanyGetAgency jsonResponse = CompanyGetAgency.fromJson(jsonMap);
//
//   print('Status: ${jsonResponse.status}');
//   print('Message: ${jsonResponse.message}');
//   print('Data:');
//   for (var item in jsonResponse.data.list) {
//     print('  Id: ${item.id}, Name: ${item.name}');
//   }
// }
