import IGListKit
import UIKit

final class MovieSearchViewController: InfinityCollectionViewController {
    
    var handler: MovieSearchEventHandler!
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyTitleLabel: UILabel!
    @IBOutlet weak var emptyDescLabel: UILabel!
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.apply {
            $0.searchResultsUpdater = self
            $0.obscuresBackgroundDuringPresentation = false
            $0.hidesNavigationBarDuringPresentation = false
        }
        searchController.searchBar.apply {
            $0.searchBarStyle = .minimal
            $0.backgroundImage = UIImage()
            $0.delegate = self
            $0.placeholder = "Поиск"
        }
        return searchController
    }()
    
    private var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupSearchBar()
        setupViews()
        handler.didLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        collectionView.contentInset.top = 34
    }
    
    override func refresh() {
        super.refresh()
        handler.refresh()
    }

    override func loadMore() {
        handler.loadMore()
    }
    
    override func adapterCreators() -> [AdapterCreator] {
        return [
            MovieCellAdapterCreator(.init(onClick: { [weak self] item in
                self?.handler.openMovieDetail(movie: item)
            }))
        ]
    }
    
    override func setupStrings() {
        emptyTitleLabel.text = "Такого фильма нет"
        emptyDescLabel.text = "К сожалению, такой фильм отсутствует. Переформулируйте запрос или поищите другой фильм."
    }
    
    // MARK: - Private

    private func setupViews() {
        addRefreshControl()
        refreshControl?.shift = 18
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = MainTheme.shared.white
        navigationController?.navigationBar.barTintColor = MainTheme.shared.defaultColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupSearchController() {
        self.searchBar = self.searchController.searchBar
        self.navigationItem.titleView = self.searchBar
        definesPresentationContext = true
    }
    
    private func setupSearchBar() {
        let handler = weak(self|.searchDidChange) 

        [
            searchBar.rx.textDidEndEditing,
            searchBar.rx.cancelButtonClicked,
            searchBar.rx.searchButtonClicked
        ]
        .forEach { $0.subscribe(onNext: handler).disposed(by: disposeBag) }
    }
    
    private func searchDidChange() {
        self.handler.searchDidChange(text: self.searchBar.text)
    }
}

// MARK: - Extensions

extension MovieSearchViewController: MovieSearchBehavior {
    
    func set(items: [ListDiffable]) {
        emptyView.alpha = 0
        self.items = items
        self.update()
    }
    
    func set(more items: [ListDiffable]) {
        emptyView.alpha = 0
        self.items.append(contentsOf: items)
        self.update()
    }
    
    func showEmptyView() {
        emptyView.alpha = 1
    }
    
    func pageLoading(show: Bool) {
        if show {
            self.startRefreshing()
        } else {
            self.stopRefreshing()
        }
    }
}

extension MovieSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {}
}

extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchController.searchBar.showsCancelButton = false
    }
}
