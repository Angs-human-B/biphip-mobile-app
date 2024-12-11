

class Region{
  String region = '';
  String date = "";
  String time = "";
  String number_format = "";

  Region();

  Region.fromJSON(Map<String, dynamic> jsonMap):
      region = jsonMap['region'] != null? jsonMap['region'] : "",
        date = jsonMap['date'] != null? jsonMap['date'] : "",
        time = jsonMap['time'] != null? jsonMap['time'] : "",
        number_format = jsonMap['number_format'] != null? jsonMap['number_format'] : "";
}