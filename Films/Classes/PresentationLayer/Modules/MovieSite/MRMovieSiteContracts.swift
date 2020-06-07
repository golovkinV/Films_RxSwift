import UIKit

// MARK: - Contracts

protocol MovieSiteBehavior: WaitingBehavior  {
    func set(url: URL)
}

protocol MovieSiteEventHandler: ViewControllerEventHandler {
    func bind(view: MovieSiteBehavior, router: MovieSiteRoutable)
    func moduleDidCreate(url: String)
}
