import Foundation

public final class Movie: NSObject, Decodable {
    public var id: Int = .init()
    public var title: String = String()
    public var voteAverage: Double = .init()
    public var overview: String = String()
    public var genres: [Genre] = []
    public var genreIds: [Int] = []
    public var posterUrl: URL?
    
    override init() {}
    
    public init(from decoder: Decoder) throws {
        super.init()
        try decoder.apply {
            id <- $0["id"]
            title <- $0["title"]
            overview <- $0["overview"]
            voteAverage <- $0["vote_average"]
            genreIds <- $0["genre_ids"]
            
            var url = String()
            url <- $0["poster_path"]
            posterUrl = URL(string: "\(Configuration.images)\(url)")
        }
    }
}
