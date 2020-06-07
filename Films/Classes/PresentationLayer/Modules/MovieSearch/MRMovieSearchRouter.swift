import UIKit

// MARK: - Router

protocol MovieSearchRoutable: BaseRoutable, MovieDetailRoute {}

final class MovieSearchRouter: BaseRouter, MovieSearchRoutable {}
