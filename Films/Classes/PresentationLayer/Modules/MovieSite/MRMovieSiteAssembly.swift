import UIKit


// MARK: - Assembly

final class MovieSiteAssembly {
    class func createModule(url: String, parent: Router? = nil) -> MovieSiteViewController {
        let module = MovieSiteViewController()
        let router = MovieSiteRouter(view: module, parent: parent)
        module.handler = MainAppCoordinator.shared.container.resolve()
        module.handler.bind(view: module, router: router)
        module.handler.moduleDidCreate(url: url)
        return module
    }
}

// MARK: - Route

protocol MovieSiteRoute {
    func openMovieSite(url: String)
}

extension MovieSiteRoute where Self: RouterProtocol {
    func openMovieSite(url: String) {
        let module = MovieSiteAssembly.createModule(url: url, parent: self)
        PushRouter.init(target: module, parent: controller).move()
    }
}
