import UIKit

// MARK: - Assembly

final class MainViewAssembly {
    class func createModule() -> MainViewController {
        let module = MainViewController()
        module.handler = MainAppCoordinator.shared.container.resolve()
        module.handler.bind(view: module, router: MainViewRouter(view: module))
        return module
    }
}
