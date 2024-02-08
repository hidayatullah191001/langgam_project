class FileModel {
  int? id;
  String? name;
  int? width;
  int? height;
  String? ext;
  String? url;

  FileModel({
    this.id,
    this.name,
    this.width,
    this.height,
    this.ext,
    this.url,
  });

  FileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    width = json['width'];
    height = json['height'];
    ext = json['ext'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['width'] = this.width;
    data['height'] = this.height;
    data['ext'] = this.ext;
    data['url'] = this.url;
    return data;
  }
}
