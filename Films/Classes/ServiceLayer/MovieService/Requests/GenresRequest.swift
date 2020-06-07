public struct GenresRequest: BackendAPIRequest {
    typealias ResponseObject = GenreData<Genre>

    private(set) var baseUrl: String = Configuration.server
    private(set) var apiVersion: String = "3"
    private(set) var endpoint: String = "/genre/movie/list"
    private(set) var method: NetworkManager.Method = .GET
    private(set) var parameters: [String: Any] = [:]

    init() {
        self.parameters = [
            "api_key": Configuration.apiV3Key,
            "language": Configuration.language
        ]
    }
}
