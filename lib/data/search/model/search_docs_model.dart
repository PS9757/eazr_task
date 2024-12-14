import 'package:eazr/domain/search/entity/search_docs_entity.dart';

class SearchDocsModel extends SearchDocsEntity {
  SearchDocsModel({
    required super.searchDocsEntityAbstract,
    required super.webUrl,
    required super.snippet,
    required super.leadParagraph,
    required super.source,
    required super.multimedia,
    required super.headline,
    required super.keywords,
    required super.pubDate,
    required super.documentType,
    required super.newsDesk,
    required super.sectionName,
    required super.byline,
    required super.typeOfMaterial,
    required super.id,
    required super.wordCount,
    required super.uri,
  });

  factory SearchDocsModel.fromJson(Map<String, dynamic> json) =>
      SearchDocsModel(
        searchDocsEntityAbstract: json["abstract"],
        webUrl: json["web_url"],
        snippet: json["snippet"],
        leadParagraph: json["lead_paragraph"],
        source: json["source"],
        multimedia: List<Multimedia>.from(
            json["multimedia"].map((x) => Multimedia.fromJson(x))),
        headline: Headline.fromJson(json["headline"]),
        keywords: List<Keyword>.from(
            json["keywords"].map((x) => Keyword.fromJson(x))),
        pubDate: json["pub_date"],
        documentType: json["document_type"],
        newsDesk: json["news_desk"],
        sectionName: json["section_name"],
        byline: Byline.fromJson(json["byline"]),
        typeOfMaterial: json["type_of_material"],
        id: json["_id"],
        wordCount: json["word_count"],
        uri: json["uri"],
      );

  @override
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
}

class Byline extends BylineEntity {
  Byline({
    required super.original,
    required super.person,
    required super.organization,
  });

  factory Byline.fromJson(Map<String, dynamic> json) => Byline(
        original: json["original"] ?? '',
        person: json['person'] == null? [] :
            List<Person>.from(json["person"].map((x) => Person.fromJson(x))),
        organization: json["organization"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "original": original,
        "person": List<dynamic>.from(person.map((x) => x.toJson())),
        "organization": organization,
      };
}

class Person extends PersonEntity {
  Person({
    required super.firstname,
    required super.middlename,
    required super.lastname,
    required super.qualifier,
    required super.title,
    required super.role,
    required super.organization,
    required super.rank,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        firstname: json["firstname"] ?? '',
        middlename: json["middlename"] ?? '',
        lastname: json["lastname"] ?? '',
        qualifier: json["qualifier"] ?? '',
        title: json["title"] ?? '',
        role: json["role"] ?? '',
        organization: json["organization"] ?? '',
        rank: json["rank"] ?? '',
      );

  @override
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
}

class Headline extends HeadlineEntity {
  Headline({
    required super.main,
    required super.kicker,
    required super.contentKicker,
    required super.printHeadline,
    required super.name,
    required super.seo,
    required super.sub,
  });

  factory Headline.fromJson(Map<String, dynamic> json) => Headline(
        main: json["main"] ?? '',
        kicker: json["kicker"] ?? '',
        contentKicker: json["content_kicker"]   ?? '',
        printHeadline: json["print_headline"] ?? '',
        name: json["name"] ?? '',
        seo: json["seo"] ?? '',
        sub: json["sub"] ?? '',
      );

  @override
  Map<String, dynamic> toJson() => {
        "main": main,
        "kicker": kicker,
        "content_kicker": contentKicker,
        "print_headline": printHeadline,
        "name": name,
        "seo": seo,
        "sub": sub,
      };
}

class Keyword extends KeywordEntity {
  Keyword({
    required super.name,
    required super.value,
    required super.rank,
    required super.major,
  });

  factory Keyword.fromJson(Map<String, dynamic> json) => Keyword(
        name: json["name"],
        value: json["value"],
        rank: json["rank"],
        major: json["major"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
        "rank": rank,
        "major": major,
      };
}

class Multimedia extends MultimediaEntity {
  Multimedia({
    required super.rank,
    required super.subtype,
    required super.caption,
    required super.credit,
    required super.type,
    required super.url,
    required super.height,
    required super.width,
    required super.legacy,
    required super.subType,
    required super.cropName,
  });

  factory Multimedia.fromJson(Map<String, dynamic> json) => Multimedia(
        rank: json["rank"],
        subtype: json["subtype"],
        caption: json["caption"],
        credit: json["credit"],
        type: typeValues.map[json["type"]] ?? Type.IMAGE,
        url: json["url"],
        height: json["height"],
        width: json["width"],
        legacy: Legacy.fromJson(json["legacy"]),
        subType: json["subType"],
        cropName: json["crop_name"],
      );

  @override
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
}

class Legacy extends LegacyEntity {
  Legacy({
    super.xlarge,
    super.xlargewidth,
    super.xlargeheight,
    super.thumbnail,
    super.thumbnailwidth,
    super.thumbnailheight,
    super.widewidth,
    super.wideheight,
    super.wide,
  });

  factory Legacy.fromJson(Map<String, dynamic> json) => Legacy(
        xlarge: json["xlarge"],
        xlargewidth: json["xlargewidth"],
        xlargeheight: json["xlargeheight"],
        thumbnail: json["thumbnail"],
        thumbnailwidth: json["thumbnailwidth"],
        thumbnailheight: json["thumbnailheight"],
        widewidth: json["widewidth"],
        wideheight: json["wideheight"],
        wide: json["wide"],
      );

  @override
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
}

enum Type { IMAGE }

final typeValues = EnumValues({"image": Type.IMAGE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
