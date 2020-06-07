import IGListKit

final class MainViewController: InfinityCollectionViewController {

    var handler: MainViewEventHandler!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        handler.didLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
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
    
    // MARK: - Private
    
    private func setupViews() {
        title = "Фильмы в кинотеатрах"
        self.addRefreshControl()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = MainTheme.shared.white
        navigationController?.navigationBar.barTintColor = MainTheme.shared.defaultColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let button = UIButton(type: .custom).apply {
            $0.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            $0.setImage(#imageLiteral(resourceName: "Search Glyph"), for: .normal)
            $0.addTarget(self, action:#selector(openMovieSearch), for: .touchUpInside)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc func openMovieSearch() {
        handler.openMovieSearch()
    }
}

// MARK: - Extentions

extension MainViewController: MainViewBehavior {
    func set(items: [ListDiffable]) {
        self.items = items
        self.update()
    }
    
    func set(more items: [ListDiffable]) {
        self.items.append(contentsOf: items)
        self.update()
    }
    
    func pageLoading(show: Bool) {
        if show {
            self.startRefreshing()
        } else {
            self.stopRefreshing() 
        }
    }
}
