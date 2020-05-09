class ListData {
  final String title;
  final String useBy;
  bool isAdd = false;

  ListData(
      this.title,
      this.useBy,
      this.isAdd);

  ListData.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        useBy = json["use-by"];

}