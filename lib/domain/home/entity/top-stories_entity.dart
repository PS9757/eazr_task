import 'package:equatable/equatable.dart';

class TopStoriesEntity extends Equatable {
  final String section;
  final String subsection;
  final String title;
  final String topStoriesModelAbstract;
  final String url;
  final String uri;
  final String byline;
  final String itemType;
  final DateTime updatedDate;
  final DateTime createdDate;
  final DateTime publishedDate;
  final String materialTypeFacet;
  final String kicker;
  final List<String> desFacet;
  final List<String> orgFacet;
  final List<String> perFacet;
  final List<dynamic> geoFacet;
  final List<MultimediaEntity> multimedia;
  final String shortUrl;

  const TopStoriesEntity({
    required this.section,
    required this.subsection,
    required this.title,
    required this.topStoriesModelAbstract,
    required this.url,
    required this.uri,
    required this.byline,
    required this.itemType,
    required this.updatedDate,
    required this.createdDate,
    required this.publishedDate,
    required this.materialTypeFacet,
    required this.kicker,
    required this.desFacet,
    required this.orgFacet,
    required this.perFacet,
    required this.geoFacet,
    required this.multimedia,
    required this.shortUrl,
  });

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

  @override
  List<Object?> get props => [
        section,
        subsection,
        title,
        topStoriesModelAbstract,
        url,
        uri,
        byline,
        itemType,
        updatedDate,
        createdDate,
        publishedDate,
        materialTypeFacet,
        kicker,
        desFacet,
        orgFacet,
        perFacet,
        geoFacet,
        multimedia,
        shortUrl,
      ];
}

class MultimediaEntity extends Equatable {
  String url;
  String format;
  int height;
  int width;
  String type;
  String subtype;
  String caption;
  String copyright;

  MultimediaEntity({
    required this.url,
    required this.format,
    required this.height,
    required this.width,
    required this.type,
    required this.subtype,
    required this.caption,
    required this.copyright,
  });

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

  @override
  List<Object?> get props => [
        url,
        format,
        height,
        width,
        type,
        subtype,
        caption,
      ];
}
