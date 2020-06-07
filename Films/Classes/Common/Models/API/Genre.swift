import Foundation


public final class Genre: NSObject, Decodable {
    public var id: Int = .init()
    public var name: String = String()
    
    override init() {}
    
    public init(from decoder: Decoder) throws {
        super.init()
        try decoder.apply {
            id <- $0["id"]
            name <- $0["name"]
        }
    }
}
