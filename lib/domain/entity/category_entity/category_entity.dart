import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String slugName;
  final String section;
  final String subsection;
  final String title;
  final String categoryEntityAbstract;
  final String uri;
  final String url;
  final String byline;
  final String itemType;
  final String source;
  final DateTime updatedDate;
  final DateTime createdDate;
  final DateTime publishedDate;
  final DateTime firstPublishedDate;
  final String materialTypeFacet;
  final String kicker;
  final String subheadline;
  final List<String> desFacet;
  final List<String> orgFacet;
  final List<String> perFacet;
  final List<dynamic> geoFacet;
  final List<dynamic> relatedUrls;
  final List<MultimediaEntity> multimedia;

  CategoryEntity({
    required this.slugName,
    required this.section,
    required this.subsection,
    required this.title,
    required this.categoryEntityAbstract,
    required this.uri,
    required this.url,
    required this.byline,
    required this.itemType,
    required this.source,
    required this.updatedDate,
    required this.createdDate,
    required this.publishedDate,
    required this.firstPublishedDate,
    required this.materialTypeFacet,
    required this.kicker,
    required this.subheadline,
    required this.desFacet,
    required this.orgFacet,
    required this.perFacet,
    required this.geoFacet,
    required this.relatedUrls,
    required this.multimedia,
  });

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

  @override
  List<Object?> get props => [
        slugName,
        section,
        subsection,
        title,
        categoryEntityAbstract,
        uri,
        url,
        byline,
        itemType,
        source,
        updatedDate,
        createdDate,
        publishedDate,
        firstPublishedDate,
        materialTypeFacet,
        kicker,
        subheadline,
        desFacet,
        orgFacet,
        perFacet,
        geoFacet,
        relatedUrls,
        multimedia,
      ];
}

class MultimediaEntity extends Equatable {
  final String url;
  final String format;
  final int height;
  final int width;
  final String type;
  final String subtype;
  final String caption;
  final String copyright;

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
