import 'package:equatable/equatable.dart';

final class ThemeSummary extends Equatable {
  const ThemeSummary({required this.commune, required this.links});

  final String commune;
  final List<ThemeSummaryLink> links;

  @override
  List<Object> get props => [commune, links];
}

sealed class ThemeSummaryLink extends Equatable {
  const ThemeSummaryLink({required this.label});

  final String label;

  @override
  List<Object> get props => [label];
}

final class ThemeSummaryInternalLink extends ThemeSummaryLink {
  const ThemeSummaryInternalLink({required super.label, required this.route});

  final String route;

  @override
  List<Object> get props => [...super.props, route];
}

final class ThemeSummaryExternalLink extends ThemeSummaryLink {
  const ThemeSummaryExternalLink({required super.label, required this.url});

  final String url;

  @override
  List<Object> get props => [...super.props, url];
}
