enum GeographicalScale {
  country,
  region,
  departement,
  metropole,
  agglomeration,
  cc,
  cu,
  ca,
  city;

  static GeographicalScale fromJson(final String scale) => switch (scale) {
    'National' => country,
    'Région' => region,
    'Département' => departement,
    'Métropole' => metropole,
    'Agglomération' => agglomeration,
    'Communauté de communes' => cc,
    'Communauté urbaine' => cu,
    "Communauté d'agglomération" => ca,
    'Commune' => city,
    _ => throw ArgumentError('Unknown geographical scale: $scale'),
  };

  int compareTo(final GeographicalScale? other) => other == null ? 1 : index.compareTo(other.index);
}
