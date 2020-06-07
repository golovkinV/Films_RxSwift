import IGListKit

// MARK: - Contracts

protocol MainViewBehavior: WaitingBehavior {
    func set(items: [ListDiffable])
    func set(more items: [ListDiffable])
    func pageLoading(show: Bool)
}

protocol MainViewEventHandler: ViewControllerEventHandler, InfinityLoadingEventHandler {
    func bind(view: MainViewBehavior, router: MainViewRoutable)
    func openMovieDetail(movie: Movie)
    func openMovieSearch()
}
