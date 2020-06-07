import Foundation

public final class URLBaseConverter: Converter {
    public typealias FromValue = String?
    public typealias ToValue = URL?
    private let baseUrl = Configuration.images
    
    public func convert(from item: String?) -> URL? {
        guard let pathComponent = item,
            pathComponent.isEmpty == false,
            let url = URL(string: baseUrl),
            let scheme = url.scheme
        else { return nil }

        var components = URLComponents()
        components.scheme = scheme
        components.host = url.host

        return components.url?.appendingPathComponent(pathComponent)
    }
}

