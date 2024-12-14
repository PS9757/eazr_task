import 'package:eazr/data/search/model/search_docs_model.dart';
import 'package:equatable/equatable.dart';

class SearchDocsEntity extends Equatable {
  final String searchDocsEntityAbstract;
  final String webUrl;
  final String snippet;
  final String leadParagraph;
  final String source;
  final List<MultimediaEntity> multimedia;
  final HeadlineEntity headline;
  final List<KeywordEntity> keywords;
  final String pubDate;
  final String documentType;
  final String newsDesk;
  final String sectionName;
  final BylineEntity byline;
  final String typeOfMaterial;
  final String id;
  final int wordCount;
  final String uri;

  SearchDocsEntity({
    required this.searchDocsEntityAbstract,
    required this.webUrl,
    required this.snippet,
    required this.leadParagraph,
    required this.source,
    required this.multimedia,
    required this.headline,
    required this.keywords,
    required this.pubDate,
    required this.documentType,
    required this.newsDesk,
    required this.sectionName,
    required this.byline,
    required this.typeOfMaterial,
    required this.id,
    required this.wordCount,
    required this.uri,
  });

  Map<String, dynamic> toJson() => {
        "abstract": searchDocsEntityAbstract,
        "web_url": webUrl,
        "snippet": snippet,
        "lead_paragraph": leadParagraph,
        "source": source,
        "multimedia": List<dynamic>.from(multimedia.map((x) => x.toJson())),
        "headline": headline.toJson(),
        "keywords": List<dynamic>.from(keywords.map((x) => x.toJson())),
        "pub_date": pubDate,
        "document_type": documentType,
        "news_desk": newsDesk,
        "section_name": sectionName,
        "byline": byline.toJson(),
        "type_of_material": typeOfMaterial,
        "_id": id,
        "word_count": wordCount,
        "uri": uri,
      };

  @override
  List<Object?> get props => [
        searchDocsEntityAbstract,
        webUrl,
        snippet,
        leadParagraph,
        source,
        multimedia,
        headline,
        keywords,
        pubDate,
        documentType,
        newsDesk,
        sectionName,
        byline,
        typeOfMaterial,
        id,
        wordCount,
        uri,
      ];
}

class BylineEntity extends Equatable {
  final String original;
  final List<PersonEntity> person;
  final dynamic organization;

  BylineEntity({
    required this.original,
    required this.person,
    required this.organization,
  });

  Map<String, dynamic> toJson() => {
        "original": original,
        "person": List<dynamic>.from(person.map((x) => x.toJson())),
        "organization": organization,
      };

  @override
  List<Object?> get props => [
        original,
        person,
        organization,
      ];
}

class PersonEntity extends Equatable {
  final String firstname;
  final dynamic middlename;
  final String lastname;
  final dynamic qualifier;
  final dynamic title;
  final String role;
  final String organization;
  final int rank;

  PersonEntity({
    required this.firstname,
    required this.middlename,
    required this.lastname,
    required this.qualifier,
    required this.title,
    required this.role,
    required this.organization,
    required this.rank,
  });

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "middlename": middlename,
        "lastname": lastname,
        "qualifier": qualifier,
        "title": title,
        "role": role,
        "organization": organization,
        "rank": rank,
      };

  @override
  List<Object?> get props => [
        firstname,
        middlename,
        lastname,
        qualifier,
        title,
        role,
        organization,
        rank,
      ];
}

class HeadlineEntity extends Equatable {
  final String main;
  final String kicker;
  final dynamic contentKicker;
  final dynamic printHeadline;
  final dynamic name;
  final dynamic seo;
  final dynamic sub;

  HeadlineEntity({
    required this.main,
    required this.kicker,
    required this.contentKicker,
    required this.printHeadline,
    required this.name,
    required this.seo,
    required this.sub,
  });

  Map<String, dynamic> toJson() => {
        "main": main,
        "kicker": kicker,
        "content_kicker": contentKicker,
        "print_headline": printHeadline,
        "name": name,
        "seo": seo,
        "sub": sub,
      };

  @override
  List<Object?> get props => [
        main,
        kicker,
        contentKicker,
        printHeadline,
        name,
        seo,
        sub,
      ];
}

class KeywordEntity extends Equatable {
  final String name;
  final String value;
  final int rank;
  final String major;

  KeywordEntity({
    required this.name,
    required this.value,
    required this.rank,
    required this.major,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
        "rank": rank,
        "major": major,
      };

  @override
  List<Object?> get props => [
        name,
        value,
        rank,
        major,
      ];
}

class MultimediaEntity extends Equatable {
  final int rank;
  final String subtype;
  final dynamic caption;
  final dynamic credit;
  final Type type;
  final String url;
  final int height;
  final int width;
  final LegacyEntity legacy;
  final String subType;
  final String cropName;

  MultimediaEntity({
    required this.rank,
    required this.subtype,
    required this.caption,
    required this.credit,
    required this.type,
    required this.url,
    required this.height,
    required this.width,
    required this.legacy,
    required this.subType,
    required this.cropName,
  });

  Map<String, dynamic> toJson() => {
        "rank": rank,
        "subtype": subtype,
        "caption": caption,
        "credit": credit,
        "type": typeValues.reverse[type],
        "url": url,
        "height": height,
        "width": width,
        "legacy": legacy.toJson(),
        "subType": subType,
        "crop_name": cropName,
      };

  @override
  List<Object?> get props => [
        rank,
        subtype,
        caption,
        credit,
        type,
        url,
        height,
        width,
        legacy,
        subType,
        cropName,
      ];
}

class LegacyEntity extends Equatable {
  final String? xlarge;
  final int? xlargewidth;
  final int? xlargeheight;
  final String? thumbnail;
  final int? thumbnailwidth;
  final int? thumbnailheight;
  final int? widewidth;
  final int? wideheight;
  final String? wide;

  LegacyEntity({
    this.xlarge,
    this.xlargewidth,
    this.xlargeheight,
    this.thumbnail,
    this.thumbnailwidth,
    this.thumbnailheight,
    this.widewidth,
    this.wideheight,
    this.wide,
  });

  Map<String, dynamic> toJson() => {
        "xlarge": xlarge,
        "xlargewidth": xlargewidth,
        "xlargeheight": xlargeheight,
        "thumbnail": thumbnail,
        "thumbnailwidth": thumbnailwidth,
        "thumbnailheight": thumbnailheight,
        "widewidth": widewidth,
        "wideheight": wideheight,
        "wide": wide,
      };

  @override
  List<Object?> get props => [
        xlarge,
        xlargewidth,
        xlargeheight,
        thumbnail,
        thumbnailwidth,
        thumbnailheight,
        widewidth,
        wideheight,
        wide,
      ];
}
