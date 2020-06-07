
// MARK: - Contracts

protocol MovieDetailBehavior: WaitingBehavior {
    func set(movie: MovieDetail)
}

protocol MovieDetailEventHandler: ViewControllerEventHandler {
    func bind(view: MovieDetailBehavior, router: MovieDetailRoutable)
    func moduleDidCreated(movie: Movie)
    func openHomepage()
    func openImdb()
    func share()
}
