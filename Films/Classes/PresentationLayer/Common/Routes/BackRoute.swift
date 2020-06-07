protocol BackRoute {
    func back()
    func backToRoot()
    func backToRoot(animation: Bool)
}

extension BackRoute where Self: RouterProtocol {
    func back() {
        if let nc = self.controller.navigationController, nc.viewControllers.first != self.controller {
            nc.popViewController(animated: true)
        } else {
            self.controller.dismiss(animated: true)
        }
    }

    func backToRoot() {
        self.backToRoot(animation: true)
    }

    func backToRoot(animation: Bool) {
        if let nc = self.controller.navigationController, nc.viewControllers.first != self.controller {
            nc.popToRootViewController(animated: animation)
        } else {
            self.controller.dismiss(animated: animation)
        }
    }

}
