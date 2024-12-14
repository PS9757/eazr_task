/// [Endpoint] enum contains the API Path
enum Endpoint {
  mostPopular,
  section,
  content,
  topStories,
  search,
}

/// API contains all the endpoints that
/// provides data from the backend resources
class API {
  /// Get Host
  API();

  /// Base Path of the API
  final String host = 'api.nytimes.com';

  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  Map<String, String> get apiHeaders => _headers;

  /// Endpoint Uri
  Uri endpointUri(
    Endpoint endpoint, {
    String prefix = '',
    List<String> pathSegments = const <String>[],
    Map<String, String> queryParameters = const <String, String>{},
  }) {
    return Uri(
      scheme: 'https',
      host: host,
      path: '$prefix${_path[endpoint]}${pathSegments.join('/')}',
      // pathSegments: <String>[
      //   _path[endpoint] ?? '',
      //   ...pathSegments,
      // ],
      queryParameters: queryParameters,
    );
  }

  /// Make sure the path should have the '/' prefix always
  /// when mapping endpoints
  static const Map<Endpoint, String> _path = <Endpoint, String>{
    Endpoint.mostPopular: '/svc/mostpopular/v2',
    Endpoint.section: '/svc/news/v3/content/section-list.json',
    Endpoint.content: '/svc/news/v3/content/inyt/',
    Endpoint.topStories: '/svc/topstories/v2/home.json',
    Endpoint.search: '/svc/search/v2/articlesearch.json',

  };
}
