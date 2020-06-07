import Foundation

protocol MainViewRoutable: BaseRoutable, MovieDetailRoute, MovieSearchRoute {}

final class MainViewRouter: BaseRouter, MainViewRoutable {}
