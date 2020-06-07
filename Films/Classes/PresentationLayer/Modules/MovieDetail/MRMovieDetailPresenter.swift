import DITranquillity
import RxSwift

final class MovieDetailPart: DIPart {
    public static func load(container: DIContainer) {
        container.register(MovieDetailPresenter.init)
            .as(MovieDetailEventHandler.self)
            .lifetime(.objectGraph)
    }
}

// MARK: - Presenter

final class MovieDetailPresenter {
    private let bag = DisposeBag()
    private weak var view: MovieDetailBehavior!
    private var router: MovieDetailRoutable!
    
    private var movie: Movie!
    private var movieDetail: MovieDetail!
    private var movieService: MovieService!
    private var activity: ActivityDisposable?
    init(movieService: MovieService!) {
        self.movieService = movieService
    }
}

extension MovieDetailPresenter: MovieDetailEventHandler {
    func bind(view: MovieDetailBehavior, router: MovieDetailRoutable) {
        self.view = view
        self.router = router
    }
    
    func share() {
        guard !movieDetail.homepage.isEmpty || !movieDetail.imdbUrl.isEmpty else { return }
    
        let urlStr = !movieDetail.homepage.isEmpty ? movieDetail.homepage: movieDetail.imdbUrl
        
        if let url = URL(string: urlStr) {
            router.openShare(url: url)
        }
    }
    
    func didLoad() {
        activity = view.showLoading(fullscreen: true)
        movieService
            .fetchMovieDetail(id: movie.id)
            .subscribe(onSuccess:  { [unowned self] movie in
                self.activity?.dispose()
                self.movieDetail = movie
                self.view.set(movie: movie)
            }, onError: { [unowned self] error in
                self.activity?.dispose()
                self.router.show(error: error)
            })
            .disposed(by: bag)
    }
    
    func moduleDidCreated(movie: Movie) {
        self.movie = movie
    }
    
    func openHomepage() {
        router.openMovieSite(url: movieDetail.homepage)
    }
    
    func openImdb() {
        router.openMovieSite(url: movieDetail.imdbUrl)
    }
}
