import Foundation

public final class GenreData<T: Decodable>: NSObject, Decodable {
    public var items: [T] = []

    public init(from decoder: Decoder) throws {
        super.init()
        try decoder.apply {
            self.items <- $0["genres"]
        }
    }
}
