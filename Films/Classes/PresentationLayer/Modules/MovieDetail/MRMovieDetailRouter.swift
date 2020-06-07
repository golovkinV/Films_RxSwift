import UIKit

// MARK: - Router

protocol MovieDetailRoutable: BaseRoutable, MovieSiteRoute, ShareRoute {}

final class MovieDetailRouter: BaseRouter, MovieDetailRoutable {}
