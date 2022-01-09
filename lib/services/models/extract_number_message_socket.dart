class ExtractNumberMessageSocket{
  String? number;

  ExtractNumberMessageSocket({this.number});

  ExtractNumberMessageSocket.fromJson(Map<String, dynamic> json) {
    number = json['number'];
  }
}