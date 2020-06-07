import Foundation

public final class StringToDoubleConverter: Converter {
    public typealias FromValue = String?
    public typealias ToValue = Double?

    public func convert(from item: FromValue) -> ToValue {
        guard let item = item else { return nil }
        return Double(item)
    }
}
