class University {
  String? alphaTwoCode;
  List<String>? webPages;
  // Null? stateProvince;
  String? name;
  List<String>? domains;
  String? country;

  University(
      {this.alphaTwoCode,
        this.webPages,
        // this.stateProvince,
        this.name,
        this.domains,
        this.country});

  University.fromJson(Map<String, dynamic> json) {
    alphaTwoCode = json['alpha_two_code'];
    webPages = json['web_pages'].cast<String>();
    // stateProvince = json['state-province'];
    name = json['name'];
    domains = json['domains'].cast<String>();
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alpha_two_code'] = this.alphaTwoCode;
    data['web_pages'] = this.webPages;
    // data['state-province'] = this.stateProvince;
    data['name'] = this.name;
    data['domains'] = this.domains;
    data['country'] = this.country;
    return data;
  }
}