import 'package:eazr/domain/home/entity/most_popular_entity.dart';

class PopularModel extends MostPopularEntity {
  const PopularModel({
    required super.uri,
    required super.url,
    required super.id,
    required super.assetId,
    required super.source,
    required super.publishedDate,
    required super.updated,
    required super.section,
    required super.subsection,
    required super.nytdsection,
    required super.adxKeywords,
    required super.column,
    required super.byline,
    required super.type,
    required super.title,
    required super.popularModelAbstract,
    required super.desFacet,
    required super.orgFacet,
    required super.perFacet,
    required super.geoFacet,
    required super.media,
    required super.etaId,
  });

  factory PopularModel.fromJson(Map<String, dynamic> json) => PopularModel(
        uri: json["uri"],
        url: json["url"],
        id: json["id"],
        assetId: json["asset_id"],
        source: json["source"],
        publishedDate: DateTime.parse(json["published_date"]),
        updated: DateTime.parse(json["updated"]),
        section: json["section"],
        subsection: json["subsection"],
        nytdsection: json["nytdsection"],
        adxKeywords: json["adx_keywords"],
        column: json["column"],
        byline: json["byline"],
        type: json["type"],
        title: json["title"],
        popularModelAbstract: json["abstract"],
        desFacet: List<String>.from(json["des_facet"].map((x) => x)),
        orgFacet: List<String>.from(json["org_facet"].map((x) => x)),
        perFacet: List<dynamic>.from(json["per_facet"].map((x) => x)),
        geoFacet: List<dynamic>.from(json["geo_facet"].map((x) => x)),
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        etaId: json["eta_id"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "uri": uri,
        "url": url,
        "id": id,
        "asset_id": assetId,
        "source": source,
        "published_date":
            "${publishedDate.year.toString().padLeft(4, '0')}-${publishedDate.month.toString().padLeft(2, '0')}-${publishedDate.day.toString().padLeft(2, '0')}",
        "updated": updated.toIso8601String(),
        "section": section,
        "subsection": subsection,
        "nytdsection": nytdsection,
        "adx_keywords": adxKeywords,
        "column": column,
        "byline": byline,
        "type": type,
        "title": title,
        "abstract": popularModelAbstract,
        "des_facet": List<dynamic>.from(desFacet.map((x) => x)),
        "org_facet": List<dynamic>.from(orgFacet.map((x) => x)),
        "per_facet": List<dynamic>.from(perFacet.map((x) => x)),
        "geo_facet": List<dynamic>.from(geoFacet.map((x) => x)),
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
        "eta_id": etaId,
      };
}

class Media extends MediaEntity {
  Media({
    required super.type,
    required super.subtype,
    required super.caption,
    required super.copyright,
    required super.approvedForSyndication,
    required super.mediaMetadata,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        type: json["type"],
        subtype: json["subtype"],
        caption: json["caption"],
        copyright: json["copyright"],
        approvedForSyndication: json["approved_for_syndication"],
        mediaMetadata: List<MediaMetaDatumEntity>.from(
            json["media-metadata"].map((x) => MediaMetadatum.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "type": type,
        "subtype": subtype,
        "caption": caption,
        "copyright": copyright,
        "approved_for_syndication": approvedForSyndication,
        "media-metadata":
            List<dynamic>.from(mediaMetadata.map((x) => x.toJson())),
      };
}

class MediaMetadatum extends MediaMetaDatumEntity {
  const MediaMetadatum({
    required super.url,
    required super.format,
    required super.height,
    required super.width,
  });

  factory MediaMetadatum.fromJson(Map<String, dynamic> json) => MediaMetadatum(
        url: json["url"],
        format: json["format"],
        height: json["height"],
        width: json["width"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "url": url,
        "format": format,
        "height": height,
        "width": width,
      };
}
