import Foundation

public final class HTMLConverter: Converter {
    public typealias FromValue = String?
    public typealias ToValue = NSAttributedString?

    public func convert(from item: String?) -> NSAttributedString? {
        return item?.html2AttributedString()
    }
}

