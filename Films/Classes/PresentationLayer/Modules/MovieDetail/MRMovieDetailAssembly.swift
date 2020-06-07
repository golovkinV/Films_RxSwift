import UIKit

// MARK: - Assembly

final class MovieDetailAssembly {
    class func createModule(movie: Movie, parent: Router? = nil) -> MovieDetailViewController {
        let module = MovieDetailViewController()
        let router = MovieDetailRouter(view: module, parent: parent)
        module.handler = MainAppCoordinator.shared.container.resolve()
        module.handler.bind(view: module, router: router)
        module.handler.moduleDidCreated(movie: movie)
        return module
    }
}

// MARK: - Route

protocol MovieDetailRoute {
    func openMovieDetail(_ movie: Movie)
}

extension MovieDetailRoute where Self: RouterProtocol {
    func openMovieDetail(_ movie: Movie) {
        let module = MovieDetailAssembly.createModule(movie: movie, parent: self)
        PushRouter(target: module, parent: self.controller).move()
    }
}
