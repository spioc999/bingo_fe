class NextBingoPaperRequest{
  List<int> exclude;

  NextBingoPaperRequest({required this.exclude});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['exclude'] = exclude;
    return data;
  }
}