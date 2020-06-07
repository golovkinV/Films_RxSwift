import DITranquillity
import RxSwift

final class MovieSitePart: DIPart {
    static func load(container: DIContainer) {
        container.register(MovieSitePresenter.init)
            .as(MovieSiteEventHandler.self)
            .lifetime(.objectGraph)
    }
}

// MARK: - Presenter

final class MovieSitePresenter {
    private weak var view: MovieSiteBehavior!
    private var router: MovieSiteRoutable!
    private var url: String = String()
    
    init() {}
}

extension MovieSitePresenter: MovieSiteEventHandler {
    func bind(view: MovieSiteBehavior, router: MovieSiteRoutable) {
        self.view = view
        self.router = router
    }
    
    func moduleDidCreate(url: String) {
        self.url = url
    }
    
    func didLoad() {
        if let url = URL(string: url) {
            self.view.set(url: url)
        }
    }
}
