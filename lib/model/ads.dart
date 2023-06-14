class Ads_model {
  int statusCode;
  String message;
  Ads data;

  Ads_model({this.statusCode, this.message, this.data});

  Ads_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new Ads.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Ads {
  List<Carousel> carousel;
  List<Carousel> bottom;
  List<Carousel> middle;

  Ads({this.carousel, this.bottom, this.middle});

  Ads.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      carousel = new List<Carousel>();
      json['results'].forEach((v) {
        carousel.add(new Carousel.fromJson(v));
      });
    }
    if (json['bottom'] != null) {
      bottom = new List<Carousel>();
      json['bottom'].forEach((v) {
        bottom.add(new Carousel.fromJson(v));
      });
    }
    if (json['middle'] != null) {
      middle = new List<Carousel>();
      json['middle'].forEach((v) {
        middle.add(new Carousel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.carousel != null) {
      data['carousel'] = this.carousel.map((v) => v.toJson()).toList();
    }
    if (this.bottom != null) {
      data['bottom'] = this.bottom.map((v) => v.toJson()).toList();
    }
    if (this.middle != null) {
      data['middle'] = this.middle.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Carousel {
  int id;
  String adName;
  int adPosition;
  String adUrl;
  int status;
  int cartypeId;
  String platform;
  String photo;

  Carousel(
      {this.id,
        this.adName,
        this.adPosition,
        this.adUrl,
        this.status,
        this.cartypeId,
        this.platform,
        this.photo});

  Carousel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adName = json['name'];
    adPosition = json['ad_position'];
    adUrl = json['ad_url'];
    status = json['status'];
    cartypeId = json['cartype_id'];
    platform = json['platform'];
    photo = json['image'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ad_name'] = this.adName;
    data['ad_position'] = this.adPosition;
    data['ad_url'] = this.adUrl;
    data['status'] = this.status;
    data['cartype_id'] = this.cartypeId;
    data['platform'] = this.platform;

    return data;
  }
}

class Photo {
  int id;
  int modelId;
  String uuid;
  String collectionName;
  String name;
  String fileName;
  String mimeType;
  String disk;
  String conversionsDisk;
  int size;
  int orderColumn;
  String createdAt;
  String updatedAt;
  String image;
  String url;
  String thumbnail;
  String preview;

  Photo(
      {this.id,
        this.modelId,
        this.uuid,
        this.collectionName,
        this.name,
        this.fileName,
        this.mimeType,
        this.disk,
        this.conversionsDisk,
        this.size,
        this.orderColumn,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.url,
        this.thumbnail,
        this.preview});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelId = json['model_id'];
    uuid = json['uuid'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    conversionsDisk = json['conversions_disk'];
    size = json['size'];
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    url = json['url'];
    thumbnail = json['thumbnail'];
    preview = json['preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_id'] = this.modelId;
    data['uuid'] = this.uuid;
    data['collection_name'] = this.collectionName;
    data['name'] = this.name;
    data['file_name'] = this.fileName;
    data['mime_type'] = this.mimeType;
    data['disk'] = this.disk;
    data['conversions_disk'] = this.conversionsDisk;
    data['size'] = this.size;
    data['order_column'] = this.orderColumn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['url'] = this.url;
    data['thumbnail'] = this.thumbnail;
    data['preview'] = this.preview;
    return data;
  }
}






