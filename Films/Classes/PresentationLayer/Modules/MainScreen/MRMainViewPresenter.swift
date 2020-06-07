import DITranquillity
import RxSwift

final class MainViewPart: DIPart {
    public static func load(container: DIContainer) {
        container.register(MainViewPresenter.init)
            .as(MainViewEventHandler.self)
            .lifetime(.objectGraph)
    }
}

// MARK: - Presenter

final class MainViewPresenter {
    private let bag = DisposeBag()

    private weak var view: MainViewBehavior!
    private var router: MainViewRoutable!
    private var movieService: MovieService!
    private var genres: [Genre] = []
    
    private lazy var paginator: Paginator = Paginator<Movie, IntPaging>(IntPaging()) { [unowned self] in
        return self.movieService.fetchNowPlayingMovies(since: $0)
    }
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
}

extension MainViewPresenter: MainViewEventHandler {
    
    func openMovieSearch() {
        router.openMovieSearch()
    }
    
    func bind(view: MainViewBehavior, router: MainViewRoutable) {
        self.view = view
        self.router = router
    }
    
    func didLoad() {
        fetchGenres()
        setupPaginator()
        refresh()
    }
    
    func refresh() {
        paginator.refresh()
    }

    func loadMore() {
        paginator.loadNewPage()
    }
    
    func openMovieDetail(movie: Movie) {
        router.openMovieDetail(movie) 
    }
    
    // MARK: - Private
    
    private func fetchGenres() {
        movieService
            .fetchAllGenres()
            .subscribe(onSuccess: { [unowned self] items in
                self.genres = items
            }, onError: { [unowned self] error in
                self.router.show(error: error)
            })
            .disposed(by: bag)
    }
    
    private func setGenres(_ movies: [Movie], isMore: Bool) {
        movies.forEach { movie in
            movie.genres = genres.filter { movie.genreIds.contains($0.id) }
        }
        if isMore {
            view.set(more: movies)
        } else {
            view.set(items: movies)
        }
    }
    
    private func setupPaginator() {
        let refreshAction: Action<Bool> = { [weak view] show in
            view?.pageLoading(show: show)
        }

        var activity: ActivityDisposable?
        let emptyLoadAction: Action<Bool> = { [weak view] show in
            if show {
                activity = view?.showLoading(fullscreen: false)
            } else {
                activity?.dispose()
                view?.pageLoading(show: false)
            }
        }

        self.paginator.handler
            .showData { [weak self] value in
                switch value.data {
                case let .first(items):
                    self?.loadMore()
                    self?.setGenres(items, isMore: false)
                case let .next(items):
                    self?.setGenres(items, isMore: true)
                }
        }
        .showErrorMessage { [weak view, weak router] error in
            view?.pageLoading(show: false)
            router?.show(error: error)
        }
        .showEmptyError { [weak router] value in
            activity?.dispose()
            if let error = value.error {
                router?.show(error: error)
            }
        }
        .showRefreshProgress(refreshAction)
        .showEmptyProgress(emptyLoadAction)
    }
}
