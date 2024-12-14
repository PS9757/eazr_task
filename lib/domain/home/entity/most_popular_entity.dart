import 'package:equatable/equatable.dart';

class MostPopularEntity extends Equatable {
  final String uri;
  final String url;
  final int id;
  final int assetId;
  final String source;
  final DateTime publishedDate;
  final DateTime updated;
  final String section;
  final String subsection;
  final String nytdsection;
  final String adxKeywords;
  final dynamic column;
  final String byline;
  final String type;
  final String title;
  final String popularModelAbstract;
  final List<String> desFacet;
  final List<String> orgFacet;
  final List<dynamic> perFacet;
  final List<dynamic> geoFacet;
  final List<MediaEntity> media;
  final int etaId;

  const MostPopularEntity({
    required this.uri,
    required this.url,
    required this.id,
    required this.assetId,
    required this.source,
    required this.publishedDate,
    required this.updated,
    required this.section,
    required this.subsection,
    required this.nytdsection,
    required this.adxKeywords,
    required this.column,
    required this.byline,
    required this.type,
    required this.title,
    required this.popularModelAbstract,
    required this.desFacet,
    required this.orgFacet,
    required this.perFacet,
    required this.geoFacet,
    required this.media,
    required this.etaId,
  });

  @override
  List<Object?> get props => [
        uri,
        url,
        id,
        assetId,
        source,
        publishedDate,
        updated,
        section,
        subsection,
        nytdsection,
        adxKeywords,
        column,
        byline,
        type,
        title,
        popularModelAbstract,
        desFacet,
        orgFacet,
        perFacet,
        geoFacet,
        media,
        etaId,
      ];

  //toJson
  Map<String, dynamic> toJson() => {
        "uri": uri,
        "url": url,
        "id": id,
        "asset_id": assetId,
        "source": source,
        "published_date": publishedDate.toIso8601String(),
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
        "des_facet": desFacet,
        "org_facet": orgFacet,
        "per_facet": perFacet,
        "geo_facet": geoFacet,
        "media": media.map((x) => x.toJson()).toList(),
        "eta_id": etaId,
      };
}

class MediaEntity extends Equatable {
  final String type;
  final String subtype;
  final String caption;
  final String copyright;
  final int approvedForSyndication;
  final List<MediaMetaDatumEntity> mediaMetadata;

  const MediaEntity({
    required this.type,
    required this.subtype,
    required this.caption,
    required this.copyright,
    required this.approvedForSyndication,
    required this.mediaMetadata,
  });

  //toJson
  Map<String, dynamic> toJson() => {
        "type": type,
        "subtype": subtype,
        "caption": caption,
        "copyright": copyright,
        "approved_for_syndication": approvedForSyndication,
        "media-metadata": mediaMetadata.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        type,
        subtype,
        caption,
        copyright,
        approvedForSyndication,
        mediaMetadata,
      ];
}

class MediaMetaDatumEntity extends Equatable {
  final String url;
  final String format;
  final int height;
  final int width;

  const MediaMetaDatumEntity({
    required this.url,
    required this.format,
    required this.height,
    required this.width,
  });

  //toJson
  Map<String, dynamic> toJson() => {
        "url": url,
        "format": format,
        "height": height,
        "width": width,
      };

  @override
  List<Object?> get props => [url, format, height, width];
}
