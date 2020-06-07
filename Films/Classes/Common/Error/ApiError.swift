public final class ApiError: Decodable, Error, CustomStringConvertible {
    var code: Int = 0
    var message = ""

    public init(from decoder: Decoder) throws {
        try decoder.apply { 
            message <- $0["message"]
        }
    }

    public var description: String {
        return self.message
    }
}

