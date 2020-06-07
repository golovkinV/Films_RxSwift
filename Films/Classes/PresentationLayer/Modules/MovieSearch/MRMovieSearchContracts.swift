import IGListKit

// MARK: - Contracts

protocol MovieSearchBehavior: WaitingBehavior, Weakifiable {
    func set(items: [ListDiffable])
    func set(more items: [ListDiffable])
    func pageLoading(show: Bool)
    func showEmptyView()
}

protocol MovieSearchEventHandler: ViewControllerEventHandler, InfinityLoadingEventHandler {
    func bind(view: MovieSearchBehavior, router: MovieSearchRoutable)
    func searchDidChange(text: String?)
    func openMovieDetail(movie: Movie)
}
