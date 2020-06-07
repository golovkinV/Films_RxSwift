public struct MovieSearchRequest: BackendAPIRequest {
    typealias ResponseObject = PageData<Movie>

    private(set) var baseUrl: String = Configuration.server
    private(set) var apiVersion: String = "3"
    private(set) var endpoint: String = "/search/movie"
    private(set) var method: NetworkManager.Method = .GET
    private(set) var parameters: [String: Any] = [:]

    init(since page: Int, for query: String) {
        self.parameters = [
            "api_key": Configuration.apiV3Key,
            "language": Configuration.language,
            "query": query,
            "page": page
        ]
    }
}
