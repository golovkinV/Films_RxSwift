public struct MovieDetailRequest: BackendAPIRequest {
    typealias ResponseObject = MovieDetail

    private(set) var baseUrl: String = Configuration.server
    private(set) var apiVersion: String = "3"
    private(set) var endpoint: String = "/movie"
    private(set) var method: NetworkManager.Method = .GET
    private(set) var parameters: [String: Any] = [:]

    init(id: Int) {
        endpoint = "/movie/\(id)"
        parameters = [
            "api_key": Configuration.apiV3Key,
            "language": Configuration.language
        ]
    }
}
