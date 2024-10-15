class ProfileModel {
  ProfileModel({
    required this.id,
    this.name,
    this.phone,
    this.v,
    this.about,
    this.acceptedUsers,
    this.blockedUsers,
    this.createdAt,
    this.extra,
    this.filterPref,
    this.location,
    this.otp,
    this.premium,
    this.profileStatus,
    this.rejectedUsers,
    this.updatedAt,
    this.dob,
    this.gender,
    this.orientation,
  });

  final String id;
  String? name;
  String? phone;
  int? v;
  dynamic about;
  List<dynamic>? acceptedUsers;
  List<dynamic>? blockedUsers;
  CreatedAt? createdAt;
  Extra? extra;
  FilterPref? filterPref;
  Location? location;
  Otp? otp;
  Premium? premium;
  int? profileStatus;
  List<dynamic>? rejectedUsers;
  CreatedAt? updatedAt;
  CreatedAt? dob;
  String? gender;
  String? orientation;

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json["_id"],
      name: json["name"] ,
      phone: json["phone"],
      v: json["__v"],
      about: json["about"],
      acceptedUsers: json["acceptedUsers"] == null
          ? []
          : List<dynamic>.from(json["acceptedUsers"]!.map((x) => x)),
      blockedUsers: json["blockedUsers"] == null
          ? []
          : List<dynamic>.from(json["blockedUsers"]!.map((x) => x)),
      createdAt: json["createdAt"] == null
          ? null
          : CreatedAt.fromJson(json["createdAt"]),
      extra: json["extra"] == null ? null : Extra.fromJson(json["extra"]),
      filterPref: json["filterPref"] == null
          ? null
          : FilterPref.fromJson(json["filterPref"]),
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      otp: json["otp"] == null ? null : Otp.fromJson(json["otp"]),
      premium:
          json["premium"] == null ? null : Premium.fromJson(json["premium"]),
      profileStatus: json["profileStatus"],
      rejectedUsers: json["rejectedUsers"] == null
          ? []
          : List<dynamic>.from(json["rejectedUsers"]!.map((x) => x)),
      updatedAt: json["updatedAt"] == null
          ? null
          : CreatedAt.fromJson(json["updatedAt"]),
      dob: json["dob"] == null ? null : CreatedAt.fromJson(json["dob"]),
      gender: json["gender"],
      orientation: json["orientation"],
    );
  }
  
   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["phone"] = phone;
    data["__v"] = v;
    data["about"] = about;
    data["acceptedUsers"] = acceptedUsers;
    data["blockedUsers"] = blockedUsers;
    // if (createdAt != null) {
    //   data["createdAt"] = createdAt!.toJson();
    // }
    // if (extra != null) {
    //   data["extra"] = extra!.toJson();
    // }
    // if (filterPref != null) {
    //   data["filterPref"] = filterPref!.toJson();
    // }
    // if (location != null) {
    //   data["location"] = location!.toJson();
    // }
    // if (otp != null) {
    //   data["otp"] = otp!.toJson();
    // }
    // if (premium != null) {
    //   data["premium"] = premium!.toJson();
    // }
    data["profileStatus"] = profileStatus;
    data["rejectedUsers"] = rejectedUsers;
    // if (updatedAt != null) {
    //   data["updatedAt"] = updatedAt!.toJson();
    // }
    // if (dob != null) {
    //   data["dob"] = dob!.toJson();
    // }
    data["gender"] = gender;
    data["orientation"] = orientation;
    return data;
  }
}

class CreatedAt {
  CreatedAt({
    required this.date,
  });

  final DateTime? date;

  factory CreatedAt.fromJson(Map<String, dynamic> json) {
    return CreatedAt(
      date: DateTime.tryParse(json["\u0024date"] ?? ""),
    );
  }
}

class Extra {
  Extra({
    required this.about,
    required this.job,
    required this.company,
    required this.education,
    required this.religion,
    required this.drinking,
    required this.smoking,
    required this.workout,
    required this.diet,
    required this.socialMedia,
  });

  final dynamic about;
  final String? job;
  final String? company;
  final String? education;
  final String? religion;
  final String? drinking;
  final String? smoking;
  final String? workout;
  final String? diet;
  final String? socialMedia;

  factory Extra.fromJson(Map<String, dynamic> json) {
    return Extra(
      about: json["about"],
      job: json["job"],
      company: json["company"],
      education: json["education"],
      religion: json["religion"],
      drinking: json["drinking"],
      smoking: json["smoking"],
      workout: json["workout"],
      diet: json["diet"],
      socialMedia: json["socialMedia"],
    );
  }
}

class FilterPref {
  FilterPref({
    required this.advanced,
    required this.basic,
  });

  final Advanced? advanced;
  final Basic? basic;

  factory FilterPref.fromJson(Map<String, dynamic> json) {
    return FilterPref(
      advanced: json["advanced"] = Advanced.fromJson(json["advanced"]),
      basic: json["basic"] = Basic.fromJson(json["basic"]),
    );
  }
}

class Advanced {
  Advanced({
    required this.currentCity,
    required this.diet,
    required this.drinking,
    required this.education,
    required this.height,
    required this.hometown,
    required this.political,
    required this.religion,
    required this.smoking,
    required this.socialMedia,
    required this.workout,
  });

  final List<dynamic> currentCity;
  final List<dynamic> diet;
  final List<dynamic> drinking;
  final List<dynamic> education;
  final dynamic height;
  final List<dynamic> hometown;
  final List<dynamic> political;
  final List<dynamic> religion;
  final List<dynamic> smoking;
  final List<dynamic> socialMedia;
  final List<dynamic> workout;

  factory Advanced.fromJson(Map<String, dynamic> json) {
    return Advanced(
      currentCity: json["currentCity"] == null
          ? []
          : List<dynamic>.from(json["currentCity"]!.map((x) => x)),
      diet: json["diet"] == null
          ? []
          : List<dynamic>.from(json["diet"]!.map((x) => x)),
      drinking: json["drinking"] == null
          ? []
          : List<dynamic>.from(json["drinking"]!.map((x) => x)),
      education: json["education"] == null
          ? []
          : List<dynamic>.from(json["education"]!.map((x) => x)),
      height: json["height"],
      hometown: json["hometown"] == null
          ? []
          : List<dynamic>.from(json["hometown"]!.map((x) => x)),
      political: json["political"] == null
          ? []
          : List<dynamic>.from(json["political"]!.map((x) => x)),
      religion: json["religion"] == null
          ? []
          : List<dynamic>.from(json["religion"]!.map((x) => x)),
      smoking: json["smoking"] == null
          ? []
          : List<dynamic>.from(json["smoking"]!.map((x) => x)),
      socialMedia: json["socialMedia"] == null
          ? []
          : List<dynamic>.from(json["socialMedia"]!.map((x) => x)),
      workout: json["workout"] == null
          ? []
          : List<dynamic>.from(json["workout"]!.map((x) => x)),
    );
  }
}

class Basic {
  Basic({
    required this.ageRange,
    required this.distance,
  });

  final List<int> ageRange;
  final int? distance;

  factory Basic.fromJson(Map<String, dynamic> json) {
    return Basic(
      ageRange: json["ageRange"] == null
          ? []
          : List<int>.from(json["ageRange"]!.map((x) => x)),
      distance: json["distance"] ?? 0,
    );
  }
}

class Id {
  Id({
    required this.oid,
  });

  final String? oid;

  factory Id.fromJson(Map<String, dynamic> json) {
    return Id(
      oid: json["\u0024oid"],
    );
  }
}

class Location {
  Location({
    required this.type,
    required this.coordinates,
  });

  final String? type;
  final List<double> coordinates;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json["type"],
      coordinates: json["coordinates"] == null
          ? []
          : List<double>.from(json["coordinates"]!.map((x) => x)),
    );
  }
}

class Otp {
  Otp({
    required this.value,
    required this.generatedAt,
  });

  final String? value;
  final CreatedAt? generatedAt;

  factory Otp.fromJson(Map<String, dynamic> json) {
    return Otp(
      value: json["value"],
      generatedAt: json["generatedAt"] == null
          ? null
          : CreatedAt.fromJson(json["generatedAt"]),
    );
  }
}

class Premium {
  Premium({
    required this.enabled,
    required this.msg,
  });

  final String? enabled;
  final int? msg;

  factory Premium.fromJson(Map<String, dynamic> json) {
    return Premium(
      enabled: json["enabled"],
      msg: json["msg"],
    );
  }
}
