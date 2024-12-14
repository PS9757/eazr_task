import 'package:eazr/domain/entity/category_entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.slugName,
    required super.section,
    required super.subsection,
    required super.title,
    required super.categoryEntityAbstract,
    required super.uri,
    required super.url,
    required super.byline,
    required super.itemType,
    required super.source,
    required super.updatedDate,
    required super.createdDate,
    required super.publishedDate,
    required super.firstPublishedDate,
    required super.materialTypeFacet,
    required super.kicker,
    required super.subheadline,
    required super.desFacet,
    required super.orgFacet,
    required super.perFacet,
    required super.geoFacet,
    required super.relatedUrls,
    required super.multimedia,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        slugName: json["slug_name"],
        section: json["section"],
        subsection: json["subsection"],
        title: json["title"],
        categoryEntityAbstract: json["abstract"],
        uri: json["uri"],
        url: json["url"],
        byline: json["byline"],
        itemType: json["item_type"],
        source: json["source"],
        updatedDate: DateTime.parse(json["updated_date"]),
        createdDate: DateTime.parse(json["created_date"]),
        publishedDate: DateTime.parse(json["published_date"]),
        firstPublishedDate: DateTime.parse(json["first_published_date"]),
        materialTypeFacet: json["material_type_facet"],
        kicker: json["kicker"],
        subheadline: json["subheadline"],
        desFacet: List<String>.from(json["des_facet"].map((x) => x)),
        orgFacet: List<String>.from(json["org_facet"].map((x) => x)),
        perFacet: List<String>.from(json["per_facet"].map((x) => x)),
        geoFacet: List<dynamic>.from(json["geo_facet"].map((x) => x)),
        relatedUrls: List<dynamic>.from(json["related_urls"].map((x) => x)),
        multimedia: List<Multimedia>.from(
            json["multimedia"].map((x) => Multimedia.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "slug_name": slugName,
        "section": section,
        "subsection": subsection,
        "title": title,
        "abstract": categoryEntityAbstract,
        "uri": uri,
        "url": url,
        "byline": byline,
        "item_type": itemType,
        "source": source,
        "updated_date": updatedDate.toIso8601String(),
        "created_date": createdDate.toIso8601String(),
        "published_date": publishedDate.toIso8601String(),
        "first_published_date": firstPublishedDate.toIso8601String(),
        "material_type_facet": materialTypeFacet,
        "kicker": kicker,
        "subheadline": subheadline,
        "des_facet": List<dynamic>.from(desFacet.map((x) => x)),
        "org_facet": List<dynamic>.from(orgFacet.map((x) => x)),
        "per_facet": List<dynamic>.from(perFacet.map((x) => x)),
        "geo_facet": List<dynamic>.from(geoFacet.map((x) => x)),
        "related_urls": List<dynamic>.from(relatedUrls.map((x) => x)),
        "multimedia": List<dynamic>.from(multimedia.map((x) => x.toJson())),
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
