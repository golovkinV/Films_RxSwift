//
//  MovieDetailViewController.swift
//  Films
//
//  Created by MintRocket on 17.05.2020.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class MovieDetailViewController: BaseCollectionViewController {

    var handler: MovieDetailEventHandler!
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var contentScroll: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var containerInfoView: UIView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    // Year Content
    @IBOutlet weak var yearView: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    
    // Date Release Content
    @IBOutlet weak var dateReleaseView: UIView!
    @IBOutlet weak var dateReleaseLabel: UILabel!
    
    // Runtime Content
    @IBOutlet weak var runtimeView: UIView!
    @IBOutlet weak var runtimeLabel: UILabel!
    
    // Movie Site Content
    @IBOutlet weak var moviewSiteView: UIView!
    @IBOutlet weak var movieSiteLabel: UILabel!
    
    // IMDb Content
    @IBOutlet weak var imdbView: UIView!
    @IBOutlet weak var imdbLabel: UILabel!
    
    @IBAction func onShareClick(_ sender: Any) {
        handler.share()
    }
    
    @IBAction func onHomepageTap(_ sender: Any) {
        handler.openHomepage()
    }
    
    @IBAction func onImdbTap(_ sender: Any) {
        handler.openImdb()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handler.didLoad()
        setupViews()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTranparentNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupScrollInset()
    }
    
    override func adapterCreators() -> [AdapterCreator] {
        return [
            GenreCellAdapterCreator()
        ]
    }
    
    // MARK: - Private

    private func setupViews() {
        self.collectionView.contentInset.bottom = 0
        shareButton.layer.cornerRadius = 15
        containerInfoView.layer.cornerRadius = 5
        yearView.layer.cornerRadius = 5
        dateReleaseView.layer.cornerRadius = 5
        imdbView.layer.cornerRadius = 5
        moviewSiteView.layer.cornerRadius = 5
        runtimeView.layer.cornerRadius = 5
    }
    
    private func setupScrollInset() {
        self.contentScroll.contentInset.top = self.contentScroll.bounds.height - self.headerView.frame.maxY
        self.contentScroll.setContentOffset(CGPoint.zero, animated: false)
    }

    private func setTranparentNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    
}

// MARK: - Extensions

extension MovieDetailViewController: MovieDetailBehavior {
    func set(movie: MovieDetail) {
        posterImage.setImage(from: movie.posterUrl)
        
        originalTitleLabel.text = movie.originalTitle
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        
        let releaseDate = movie.releaseDate
        yearLabel.text = "\(releaseDate.year!)"
        let releaseDay = releaseDate.day!
        let releaseMonth = releaseDate.month!
        let day = 1 <= releaseDay && releaseDay <= 9 ? "0\(releaseDay)": "\(releaseDay)"
        let month = 1 <= releaseMonth && releaseMonth <= 9 ? "0\(releaseMonth)": "\(releaseMonth)"
        dateReleaseLabel.text = "\(day).\(month).\(releaseDate.year!)"
        
        let time = movie.runtime.minuteToHoursMinutes()
        runtimeLabel.text = "Фильм длится \(time.0) ч. \(time.1) мин."
        runtimeView.isHidden = time.0 == 0 && time.1 == 0
        
        let homepage = movie.homepage
        movieSiteLabel.text = homepage
        moviewSiteView.isHidden = homepage.isEmpty
        
        let imdb = movie.imdbUrl
        imdbLabel.text = imdb
        imdbView.isHidden = imdb.isEmpty
        
        shareButton.isHidden = movie.homepage.isEmpty && movie.imdbUrl.isEmpty
        
        self.items = movie.genres
        self.update()
    }
}
