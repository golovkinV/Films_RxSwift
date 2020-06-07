import DITranquillity
import RxSwift
import RxCocoa

final class MovieServicePart: DIPart {
    static func load(container: DIContainer) {
        container.register(MovieServiceImp.init)
            .as(MovieService.self)
            .lifetime(.perRun(.weak))
    }
}

protocol MovieService {
    func fetchNowPlayingMovies(since page: Int) -> Single<[Movie]>
    func fetchAllGenres() -> Single<[Genre]>
    func fetchMoviesWithGenres(since page: Int) -> Single<([Movie], [Genre])>
    func fetchMovieDetail(id: Int) -> Single<MovieDetail>
    func searchMovie(page: Int, searchText: String) -> Single<[Movie]>
}

final class MovieServiceImp: MovieService {
    
    let schedulers: SchedulerProvider
    let backendRepository: BackendRepository
    
    init(schedulers: SchedulerProvider,
         backendRepository: BackendRepository) {
        self.schedulers = schedulers
        self.backendRepository = backendRepository
    }
    
    func searchMovie(page: Int, searchText: String) -> Single<[Movie]> {
        return Single.deferred {
            let request = MovieSearchRequest(since: page, for: searchText) 
            return self.backendRepository
                .request(request)
                .map { $0.items }
        }
        .subscribeOn(schedulers.background)
        .observeOn(schedulers.main)
    }
    
    func fetchNowPlayingMovies(since page: Int) -> Single<[Movie]> {
        return Single.deferred { [unowned self] in
            let request = NowPlayingMoviesRequest(since: page)
            return self.backendRepository
                .request(request)
                .map { $0.items }
        }
        .subscribeOn(self.schedulers.background)
        .observeOn(self.schedulers.main)
    }
    
    func fetchAllGenres() -> Single<[Genre]> {
        return Single.deferred { [unowned self] in
            let request = GenresRequest()
            return self.backendRepository
                .request(request)
                .map { $0.items }
        }
        .subscribeOn(self.schedulers.background)
        .observeOn(self.schedulers.main)
    }
    
    func fetchMoviesWithGenres(since page: Int) -> Single<([Movie], [Genre])> {
        let movies = fetchNowPlayingMovies(since: page)
        let genres = fetchAllGenres()
        return Single.zip(movies, genres)
            .subscribeOn(schedulers.background)
            .observeOn(schedulers.main)
    }
    
    func fetchMovieDetail(id: Int) -> Single<MovieDetail> {
        return Single.deferred { [unowned self] in
            let request = MovieDetailRequest(id: id)
            return self.backendRepository
                .request(request)
        }
        .subscribeOn(self.schedulers.background)
        .observeOn(self.schedulers.main)
    }
}

