import IGListKit

final class MovieCell: BaseCollectionCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var alphaView: UIView!
    
    
    private var movie: Movie!
    var onDetailClick: Action<Movie>!
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }
    
    @discardableResult
    func configure(_ movie: Movie) -> MovieCell {
        self.movie = movie
        titleLabel.text = movie.title
        posterImage.setImage(from: movie.posterUrl)
        infoLabel.text = movie.overview
        let voteAverage = round(movie.voteAverage)
        voteAverageLabel.text = "\(voteAverage)"
        
        self.items = movie.genres
        self.reload()
        
        return self
    }
    
    @IBAction func onClick(_ sender: Any) {
        onDetailClick(movie)
    }
    
    override func adapterCreators() -> [AdapterCreator] {
        return [
            GenreCellAdapterCreator()
        ]
    }
    
    // MARK: - Private
    
    private func setupStyle() {
        containerView.layer.cornerRadius = 8
        posterImage.layer.cornerRadius = 8
        alphaView.layer.cornerRadius = 8
        voteAverageLabel.layer.cornerRadius = 2
        detailButton.apply {
            $0.layer.cornerRadius = 15
            $0.setTitle("Подробнее", for: .normal)
        }
    }
}
