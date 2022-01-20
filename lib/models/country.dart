class Country {
  String name;
  String iso2;
  String iso3;

  Country(this.name, this.iso2, this.iso3);

  Country.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        iso2 = json['Iso2'],
        iso3 = json['Iso3'];
}
