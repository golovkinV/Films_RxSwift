public struct NowPlayingMoviesRequest: BackendAPIRequest { 
    typealias ResponseObject = PageData<Movie>

    private(set) var baseUrl: String = Configuration.server
    private(set) var apiVersion: String = "3"
    private(set) var endpoint: String = "/movie/now_playing"
    private(set) var method: NetworkManager.Method = .GET
    private(set) var parameters: [String: Any] = [:]

    init(since page: Int) {
        self.parameters = [
            "api_key": Configuration.apiV3Key,
            "language": Configuration.language,
            "page": page
        ]
    }
}
