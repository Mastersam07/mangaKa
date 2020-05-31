class MangaDetails {
  String alias;
  String author;
  List<String> categories;
  Chapters chapters;
  int chaptersLen;
  double created;
  String description;
  int hits;
  String image;
  String title;
  List<String> titleKw;
  int status;
  String startsWith;

  MangaDetails(
      {this.alias,
      this.author,
      this.categories,
      this.chapters,
      this.chaptersLen,
      this.created,
      this.description,
      this.hits,
      this.image,
      this.startsWith,
      this.status,
      this.title,
      this.titleKw});

  MangaDetails.fromJson(Map<String, dynamic> json) {
    alias = json['alias'];
    author = json['author'];
    categories = json['categories'].cast<String>();
//    chaptersId = json['chapters'][3];
    chapters = Chapters.fromList(json["chapters"]);
    chaptersLen = json['chapters_len'];
    created = json['created'];
    description = json['description'];
    hits = json['hits'];
    image = json['image'];
    startsWith = json['startsWith'];
    status = json['status'];
    title = json['title'];
    titleKw = json['title_kw'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alias'] = this.alias;
    data['author'] = this.author;
    data['categories'] = this.categories;
    data['chapters'] = this.chapters;
    data['chapters_len'] = this.chaptersLen;
    data['created'] = this.created;
    data['description'] = this.description;
    data['hits'] = this.hits;
    data['image'] = this.image;
    data['startsWith'] = this.startsWith;
    data['status'] = this.status;
    data['title'] = this.title;
    data['title_kw'] = this.titleKw;
    return data;
  }
}

class Chapters {
  List<Items> chapters;

  Chapters({this.chapters});

  factory Chapters.fromList(List chapterData) {
    List<Items> itemList =
        chapterData.map((items) => Items.fromList(items)).toList();
    return Chapters(chapters: itemList);
  }
}

class Items {
  String data1;
  String data2;
  String data3;
  String data4;

  Items({this.data1, this.data2, this.data3, this.data4});

  factory Items.fromList(List myData) {
    return Items(
        data1: myData[0].toString(),
        data2: myData[1].toString(),
        data3: myData[2].toString(),
        data4: myData[3].toString());
  }
}
