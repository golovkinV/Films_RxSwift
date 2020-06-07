import UIKit

public protocol AppTheme {
    func apply()

    // MARK: - Colors

    var white: UIColor { get }
    var black: UIColor { get }
    var defaultColor: UIColor { get }

    var defaultFont: AppFont? { get }

}

public struct MainTheme: AppTheme {
    public static var shared: AppTheme = MainTheme()

    public func apply() {}

    // MARK: - Colors

    public var white: UIColor = .white
    public var black: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    public var defaultColor: UIColor = #colorLiteral(red: 0.09885440022, green: 0.02577871643, blue: 0.1716919243, alpha: 1)

    // MARK: - Font

    public var defaultFont: AppFont? = nil //"Rubik-Regular" as! AppFont

}
