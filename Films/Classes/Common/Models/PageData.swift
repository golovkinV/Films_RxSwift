import Foundation

public final class PageData<T: Decodable>: NSObject, Decodable {
    public var items: [T] = []
    public var pages: Int = .init()

    public init(from decoder: Decoder) throws {
        super.init()
        try decoder.apply {
            self.items <- $0["results"]
            self.pages <- $0["total_pages"]
        }
    }
}

public final class PageSingleData<T: Decodable>: NSObject, Decodable {
    public var item: T?

    public init(from decoder: Decoder) throws {
        super.init()
        try decoder.apply {
            self.item <- $0["results"]
        }
    }
}
