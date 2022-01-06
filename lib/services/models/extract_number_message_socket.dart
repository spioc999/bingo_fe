class ExtractNumberMessageSocket{
  int? number;

  ExtractNumberMessageSocket({this.number});

  ExtractNumberMessageSocket.fromJson(Map<String, dynamic> json) {
    number = int.tryParse(json['number']);
  }
}