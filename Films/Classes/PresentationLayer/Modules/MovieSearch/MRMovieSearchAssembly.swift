import UIKit

// MARK: - Assembly

final class MovieSearchAssembly {
    class func createModule(parent: Router? = nil) -> MovieSearchViewController {
        let module = MovieSearchViewController()
        let router = MovieSearchRouter(view: module, parent: parent)
        module.handler = MainAppCoordinator.shared.container.resolve()
        module.handler.bind(view: module, router: router)
        return module
    }
}


// MARK: - Route

protocol MovieSearchRoute {
    func openMovieSearch()
}

extension MovieSearchRoute where Self: RouterProtocol {
    func openMovieSearch() {
        let module = MovieSearchAssembly.createModule(parent: self)
        PushRouter(target: module, parent: controller).move()
    }
}
