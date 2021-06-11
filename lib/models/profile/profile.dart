class Profile {
  String? email;
  String? firstName;
  String? lastName;
  String? displayName;
  String? profilePicture;
  String? persona;
  String? dateOfBirth;
  String? enrolledPlan;
  String? currentBand;
  String? desiredBand;
  String? desiredSlotTime;
  Tutor? tutor;
  Mocks? mocks;
  Enrolled? enrolled;

  Profile(
      {this.email,
      this.firstName,
      this.lastName,
      this.displayName,
      this.profilePicture,
      this.persona,
      this.dateOfBirth,
      this.enrolledPlan,
      this.currentBand,
      this.desiredBand,
      this.desiredSlotTime,
      this.tutor,
      this.mocks,
      this.enrolled});

  Profile.fromJson(Map<String, dynamic> json) {
    this.email = json["email"];
    this.firstName = json["firstName"];
    this.lastName = json["lastName"];
    this.displayName = json["displayName"];
    this.profilePicture = json["profilePicture"];
    this.persona = json["persona"];
    this.dateOfBirth = json["dateOfBirth"];
    this.enrolledPlan = json["enrolledPlan"];
    this.currentBand = json["currentBand"];
    this.desiredBand = json["desiredBand"];
    this.desiredSlotTime = json["desiredSlotTime"];
    this.tutor = json["tutor"] == null ? null : Tutor.fromJson(json["tutor"]);
    this.mocks = json["mocks"] == null ? null : Mocks.fromJson(json["mocks"]);
    this.enrolled =
        json["enrolled"] == null ? null : Enrolled.fromJson(json["enrolled"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["email"] = this.email;
    data["firstName"] = this.firstName;
    data["lastName"] = this.lastName;
    data["displayName"] = this.displayName;
    data["profilePicture"] = this.profilePicture;
    data["persona"] = this.persona;
    data["dateOfBirth"] = this.dateOfBirth;
    data["enrolledPlan"] = this.enrolledPlan;
    data["currentBand"] = this.currentBand;
    data["desiredBand"] = this.desiredBand;
    data["desiredSlotTime"] = this.desiredSlotTime;
    if (this.tutor != null) data["tutor"] = this.tutor?.toJson();
    if (this.mocks != null) data["mocks"] = this.mocks?.toJson();
    if (this.enrolled != null) data["enrolled"] = this.enrolled?.toJson();
    return data;
  }
}

class Enrolled {
  Listening2? listening;
  Speaking2? speaking;
  Reading2? reading;
  Writing2? writing;

  Enrolled({this.listening, this.speaking, this.reading, this.writing});

  Enrolled.fromJson(Map<String, dynamic> json) {
    this.listening = json["listening"] == null
        ? null
        : Listening2.fromJson(json["listening"]);
    this.speaking =
        json["speaking"] == null ? null : Speaking2.fromJson(json["speaking"]);
    this.reading =
        json["reading"] == null ? null : Reading2.fromJson(json["reading"]);
    this.writing =
        json["writing"] == null ? null : Writing2.fromJson(json["writing"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listening != null) data["listening"] = this.listening?.toJson();
    if (this.speaking != null) data["speaking"] = this.speaking?.toJson();
    if (this.reading != null) data["reading"] = this.reading?.toJson();
    if (this.writing != null) data["writing"] = this.writing?.toJson();
    return data;
  }
}

class Writing2 {
  String? totalHours;
  String? completedHours;
  String? pendingHours;

  Writing2({this.totalHours, this.completedHours, this.pendingHours});

  Writing2.fromJson(Map<String, dynamic> json) {
    this.totalHours = json["totalHours"];
    this.completedHours = json["completedHours"];
    this.pendingHours = json["pendingHours"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["totalHours"] = this.totalHours;
    data["completedHours"] = this.completedHours;
    data["pendingHours"] = this.pendingHours;
    return data;
  }
}

class Reading2 {
  String? totalHours;
  String? completedHours;
  String? pendingHours;

  Reading2({this.totalHours, this.completedHours, this.pendingHours});

  Reading2.fromJson(Map<String, dynamic> json) {
    this.totalHours = json["totalHours"];
    this.completedHours = json["completedHours"];
    this.pendingHours = json["pendingHours"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["totalHours"] = this.totalHours;
    data["completedHours"] = this.completedHours;
    data["pendingHours"] = this.pendingHours;
    return data;
  }
}

class Speaking2 {
  String? totalHours;
  String? completedHours;
  String? pendingHours;

  Speaking2({this.totalHours, this.completedHours, this.pendingHours});

  Speaking2.fromJson(Map<String, dynamic> json) {
    this.totalHours = json["totalHours"];
    this.completedHours = json["completedHours"];
    this.pendingHours = json["pendingHours"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["totalHours"] = this.totalHours;
    data["completedHours"] = this.completedHours;
    data["pendingHours"] = this.pendingHours;
    return data;
  }
}

class Listening2 {
  String? totalHours;
  String? completedHours;
  String? pendingHours;

  Listening2({this.totalHours, this.completedHours, this.pendingHours});

  Listening2.fromJson(Map<String, dynamic> json) {
    this.totalHours = json["totalHours"];
    this.completedHours = json["completedHours"];
    this.pendingHours = json["pendingHours"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["totalHours"] = this.totalHours;
    data["completedHours"] = this.completedHours;
    data["pendingHours"] = this.pendingHours;
    return data;
  }
}

class Mocks {
  Listening1? listening;
  Speaking1? speaking;
  Reading1? reading;
  Writing1? writing;

  Mocks({this.listening, this.speaking, this.reading, this.writing});

  Mocks.fromJson(Map<String, dynamic> json) {
    this.listening = json["listening"] == null
        ? null
        : Listening1.fromJson(json["listening"]);
    this.speaking =
        json["speaking"] == null ? null : Speaking1.fromJson(json["speaking"]);
    this.reading =
        json["reading"] == null ? null : Reading1.fromJson(json["reading"]);
    this.writing =
        json["writing"] == null ? null : Writing1.fromJson(json["writing"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listening != null) data["listening"] = this.listening?.toJson();
    if (this.speaking != null) data["speaking"] = this.speaking?.toJson();
    if (this.reading != null) data["reading"] = this.reading?.toJson();
    if (this.writing != null) data["writing"] = this.writing?.toJson();
    return data;
  }
}

class Writing1 {
  String? completed;

  Writing1({this.completed});

  Writing1.fromJson(Map<String, dynamic> json) {
    this.completed = json["completed"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["completed"] = this.completed;
    return data;
  }
}

class Reading1 {
  String? completed;

  Reading1({this.completed});

  Reading1.fromJson(Map<String, dynamic> json) {
    this.completed = json["completed"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["completed"] = this.completed;
    return data;
  }
}

class Speaking1 {
  String? completed;

  Speaking1({this.completed});

  Speaking1.fromJson(Map<String, dynamic> json) {
    this.completed = json["completed"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["completed"] = this.completed;
    return data;
  }
}

class Listening1 {
  String? completed;

  Listening1({this.completed});

  Listening1.fromJson(Map<String, dynamic> json) {
    this.completed = json["completed"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["completed"] = this.completed;
    return data;
  }
}

class Tutor {
  List<Speaking>? speaking;
  List<Listening>? listening;
  List<Reading>? reading;
  List<Writing>? writing;

  Tutor({this.speaking, this.listening, this.reading, this.writing});

  Tutor.fromJson(Map<String, dynamic> json) {
    this.speaking = json["speaking"] == null
        ? null
        : (json["speaking"] as List).map((e) => Speaking.fromJson(e)).toList();
    this.listening = json["listening"] == null
        ? null
        : (json["listening"] as List)
            .map((e) => Listening.fromJson(e))
            .toList();
    this.reading = json["reading"] == null
        ? null
        : (json["reading"] as List).map((e) => Reading.fromJson(e)).toList();
    this.writing = json["writing"] == null
        ? null
        : (json["writing"] as List).map((e) => Writing.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.speaking != null)
      data["speaking"] = this.speaking?.map((e) => e.toJson()).toList();
    if (this.listening != null)
      data["listening"] = this.listening?.map((e) => e.toJson()).toList();
    if (this.reading != null)
      data["reading"] = this.reading?.map((e) => e.toJson()).toList();
    if (this.writing != null)
      data["writing"] = this.writing?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Writing {
  String? tutorid;
  String? active;
  String? startDate;
  String? endDate;

  Writing({this.tutorid, this.active, this.startDate, this.endDate});

  Writing.fromJson(Map<String, dynamic> json) {
    this.tutorid = json["tutorid"];
    this.active = json["active"];
    this.startDate = json["startDate"];
    this.endDate = json["endDate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["tutorid"] = this.tutorid;
    data["active"] = this.active;
    data["startDate"] = this.startDate;
    data["endDate"] = this.endDate;
    return data;
  }
}

class Reading {
  String? tutorid;
  String? active;
  String? startDate;
  String? endDate;

  Reading({this.tutorid, this.active, this.startDate, this.endDate});

  Reading.fromJson(Map<String, dynamic> json) {
    this.tutorid = json["tutorid"];
    this.active = json["active"];
    this.startDate = json["startDate"];
    this.endDate = json["endDate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["tutorid"] = this.tutorid;
    data["active"] = this.active;
    data["startDate"] = this.startDate;
    data["endDate"] = this.endDate;
    return data;
  }
}

class Listening {
  String? tutorid;
  String? active;
  String? startdate;
  String? enddate;

  Listening({this.tutorid, this.active, this.startdate, this.enddate});

  Listening.fromJson(Map<String, dynamic> json) {
    this.tutorid = json["tutorid"];
    this.active = json["active"];
    this.startdate = json["startdate"];
    this.enddate = json["enddate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["tutorid"] = this.tutorid;
    data["active"] = this.active;
    data["startdate"] = this.startdate;
    data["enddate"] = this.enddate;
    return data;
  }
}

class Speaking {
  String? tutorid;
  String? active;
  String? startdate;
  String? enddate;

  Speaking({this.tutorid, this.active, this.startdate, this.enddate});

  Speaking.fromJson(Map<String, dynamic> json) {
    this.tutorid = json["tutorid"];
    this.active = json["active"];
    this.startdate = json["startdate"];
    this.enddate = json["enddate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["tutorid"] = this.tutorid;
    data["active"] = this.active;
    data["startdate"] = this.startdate;
    data["enddate"] = this.enddate;
    return data;
  }
}
