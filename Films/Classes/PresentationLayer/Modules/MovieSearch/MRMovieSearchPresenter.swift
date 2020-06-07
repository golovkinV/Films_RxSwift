import DITranquillity
import RxSwift

final class MovieSearchPart: DIPart {
    static func load(container: DIContainer) {
        container.register(MovieSearchPresenter.init)
            .as(MovieSearchEventHandler.self)
            .lifetime(.objectGraph)
    }
}

// MARK: - Presenter

final class MovieSearchPresenter {
    private var bag = DisposeBag()
    
    private weak var view: MovieSearchBehavior!
    private var router: MovieSearchRoutable!
    private var movieService: MovieService!
    private var paginator: Paginator<Movie, IntPaging>?
    private var lastSearchedText: String? = ""
    private var genres: [Genre] = []
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
}

extension MovieSearchPresenter: MovieSearchEventHandler {
    
    func searchDidChange(text: String?) {
        guard let text = text, text != self.lastSearchedText, !text.isEmpty
        else {
            view.set(items: [])
            return
        }
        self.lastSearchedText = text
        setupPaginator(text: text)
        self.paginator?.restart()
    }
    
    func bind(view: MovieSearchBehavior, router: MovieSearchRoutable) {
        self.view = view
        self.router = router
    }
    
    func didLoad() {
        fetchGenres()
    }
    
    func refresh() {
        paginator?.refresh()
    }

    func loadMore() {
        paginator?.loadNewPage()
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
    
    private func setupPaginator(text: String) {
        
        let requestFactory: (Int) -> Single<[Movie]> = {
            self.movieService.searchMovie(page: $0, searchText: text)
        }

        self.paginator = Paginator(IntPaging(), requestFactory: requestFactory)
        
        let refreshAction: Action<Bool> = { [weak view] show in
            view?.pageLoading(show: show) 
        }

        var activity: ActivityDisposable?
        let emptyView: Action<Bool> = { [weak view] show in
            activity?.dispose()
            view?.showEmptyView()
        }
        let emptyLoadAction: Action<Bool> = { [weak view] show in 
            if show {
                activity = view?.showLoading(fullscreen: false)
            } else {
                activity?.dispose()
                view?.pageLoading(show: false)
            }
        }
        self.paginator?.handler
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
        .showEmptyView(emptyView)
    }
}
