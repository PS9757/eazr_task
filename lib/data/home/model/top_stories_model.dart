import 'package:eazr/domain/home/entity/top-stories_entity.dart';

class TopStoriesModel extends TopStoriesEntity {
  TopStoriesModel({
    required super.section,
    required super.subsection,
    required super.title,
    required super.topStoriesModelAbstract,
    required super.url,
    required super.uri,
    required super.byline,
    required super.itemType,
    required super.updatedDate,
    required super.createdDate,
    required super.publishedDate,
    required super.materialTypeFacet,
    required super.kicker,
    required super.desFacet,
    required super.orgFacet,
    required super.perFacet,
    required super.geoFacet,
    required super.multimedia,
    required super.shortUrl,
  });

  factory TopStoriesModel.fromJson(Map<String, dynamic> json) =>
      TopStoriesModel(
        section: json["section"],
        subsection: json["subsection"],
        title: json["title"],
        topStoriesModelAbstract: json["abstract"],
        url: json["url"],
        uri: json["uri"],
        byline: json["byline"],
        itemType: json["item_type"],
        updatedDate: DateTime.parse(json["updated_date"]),
        createdDate: DateTime.parse(json["created_date"]),
        publishedDate: DateTime.parse(json["published_date"]),
        materialTypeFacet: json["material_type_facet"],
        kicker: json["kicker"],
        desFacet: List<String>.from(json["des_facet"].map((x) => x)),
        orgFacet: List<String>.from(json["org_facet"].map((x) => x)),
        perFacet: List<String>.from(json["per_facet"].map((x) => x)),
        geoFacet: List<dynamic>.from(json["geo_facet"].map((x) => x)),
        multimedia: List<Multimedia>.from(
            json["multimedia"].map((x) => Multimedia.fromJson(x))),
        shortUrl: json["short_url"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "section": section,
        "subsection": subsection,
        "title": title,
        "abstract": topStoriesModelAbstract,
        "url": url,
        "uri": uri,
        "byline": byline,
        "item_type": itemType,
        "updated_date": updatedDate.toIso8601String(),
        "created_date": createdDate.toIso8601String(),
        "published_date": publishedDate.toIso8601String(),
        "material_type_facet": materialTypeFacet,
        "kicker": kicker,
        "des_facet": List<dynamic>.from(desFacet.map((x) => x)),
        "org_facet": List<dynamic>.from(orgFacet.map((x) => x)),
        "per_facet": List<dynamic>.from(perFacet.map((x) => x)),
        "geo_facet": List<dynamic>.from(geoFacet.map((x) => x)),
        "multimedia": List<dynamic>.from(multimedia.map((x) => x.toJson())),
        "short_url": shortUrl,
      };
}

class Multimedia extends MultimediaEntity {
  Multimedia({
    required super.url,
    required super.format,
    required super.height,
    required super.width,
    required super.type,
    required super.subtype,
    required super.caption,
    required super.copyright,
  });

  factory Multimedia.fromJson(Map<String, dynamic> json) => Multimedia(
        url: json["url"],
        format: json["format"],
        height: json["height"],
        width: json["width"],
        type: json["type"],
        subtype: json["subtype"],
        caption: json["caption"],
        copyright: json["copyright"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "url": url,
        "format": format,
        "height": height,
        "width": width,
        "type": type,
        "subtype": subtype,
        "caption": caption,
        "copyright": copyright,
      };
}
