// To parse this JSON data, do
//
//     final searchPlaces = searchPlacesFromJson(jsonString);

import 'dart:convert';

SearchPlaces searchPlacesFromJson(String str) => SearchPlaces.fromJson(json.decode(str));

String searchPlacesToJson(SearchPlaces data) => json.encode(data.toJson());

class SearchPlaces {
  SearchPlaces({
    this.predictions,
    this.status,
  });

  List<Prediction>? predictions;
  String? status;

  factory SearchPlaces.fromJson(Map<String, dynamic> json) => SearchPlaces(
    predictions: List<Prediction>.from(json["predictions"].map((x) => Prediction.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "predictions": List<dynamic>.from(predictions!.map((x) => x.toJson())),
    "status": status,
  };
}

class Prediction {
  Prediction({
    this.description,
    this.matchedSubstrings,
    this.placeId,
    this.reference,
    this.structuredFormatting,
    this.terms,
    this.types,
  });

  String? description;
  List<MatchedSubstring>? matchedSubstrings;
  String? placeId;
  String? reference;
  StructuredFormatting? structuredFormatting;
  List<Term>? terms;
  List<Type>? types;

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
    description: json["description"],
    matchedSubstrings: List<MatchedSubstring>.from(json["matched_substrings"].map((x) => MatchedSubstring.fromJson(x))),
    placeId: json["place_id"],
    reference: json["reference"],
    structuredFormatting: StructuredFormatting.fromJson(json["structured_formatting"]),
    terms: List<Term>.from(json["terms"].map((x) => Term.fromJson(x))),
    types: List<Type>.from(json["types"].map((x) => typeValues.map![x])),
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "matched_substrings": List<dynamic>.from(matchedSubstrings!.map((x) => x.toJson())),
    "place_id": placeId,
    "reference": reference,
    "structured_formatting": structuredFormatting!.toJson(),
    "terms": List<dynamic>.from(terms!.map((x) => x.toJson())),
    "types": List<dynamic>.from(types!.map((x) => typeValues.reverse[x])),
  };
}

class MatchedSubstring {
  MatchedSubstring({
    this.length,
    this.offset,
  });

  int? length;
  int? offset;

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) => MatchedSubstring(
    length: json["length"],
    offset: json["offset"],
  );

  Map<String, dynamic> toJson() => {
    "length": length,
    "offset": offset,
  };
}

class StructuredFormatting {
  StructuredFormatting({
    this.mainText,
    this.mainTextMatchedSubstrings,
    this.secondaryText,
  });

  String? mainText;
  List<MatchedSubstring>? mainTextMatchedSubstrings;
  String? secondaryText;

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) => StructuredFormatting(
    mainText: json["main_text"],
    mainTextMatchedSubstrings: List<MatchedSubstring>.from(json["main_text_matched_substrings"].map((x) => MatchedSubstring.fromJson(x))),
    secondaryText: json["secondary_text"],
  );

  Map<String, dynamic> toJson() => {
    "main_text": mainText,
    "main_text_matched_substrings": List<dynamic>.from(mainTextMatchedSubstrings!.map((x) => x.toJson())),
    "secondary_text": secondaryText,
  };
}

class Term {
  Term({
    this.offset,
    this.value,
  });

  int? offset;
  String? value;

  factory Term.fromJson(Map<String, dynamic> json) => Term(
    offset: json["offset"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "offset": offset,
    "value": value,
  };
}

enum Type { LOCALITY, POLITICAL, GEOCODE }

final typeValues = EnumValues({
  "geocode": Type.GEOCODE,
  "locality": Type.LOCALITY,
  "political": Type.POLITICAL
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
