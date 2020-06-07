import Foundation

public final class MovieDetail: NSObject, Decodable {
    public var originalTitle: String = String()
    public var title: String = String()
    public var genres: [Genre] = []
    public var overview: String = String()
    public var releaseDate: DateComponents = DateComponents()
    public var runtime: Int = 0
    public var homepage: String = String()
    public var imdbUrl: String = String()
    public var posterUrl: URL?
    
    override init() {}
    
    public init(from decoder: Decoder) throws {
        super.init()
        try decoder.apply {
            originalTitle <- $0["original_title"]
            title <- $0["title"]
            genres <- $0["genres"]
            overview <- $0["overview"]
            releaseDate <- $0["release_date"]
            runtime <- $0["runtime"]
            homepage <- $0["homepage"]
            
            let imdbId: String? = $0["imdb_id"]
            if let imdbId = imdbId {
                imdbUrl = "\(Configuration.imdb)\(imdbId)"
            }
            
            let date: String? = $0["release_date"]
            configureDate(from: date)
    
            let urlPoster: String? = $0["poster_path"]
            if let urlPoster = urlPoster {
                posterUrl = URL(string: "\(Configuration.images)\(urlPoster)")
            }
        }
    }
    
    private func configureDate(from date: String?) {
        guard let dateStr = date else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateStr)!
        let calendar = Calendar.current
        releaseDate = calendar.dateComponents([.year, .month, .day], from: date)
    }
}

