import UIKit

final class GenreCell: UICollectionViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    @discardableResult
    func configure(_ item: Genre) -> GenreCell{
        nameLabel.text = item.name.uppercased()
        return self
    }
    
    static func sizeForCell(_ item: Genre) -> CGSize {
        let text = item.name.uppercased()
        let font = UIFont.systemFont(ofSize: 12, weight: .regular)
        let nameLabelWidth = text.widthOfLabel(font: font)
        let nameLabelHeight = text.height(for: nameLabelWidth, font: font)
        return CGSize(width: nameLabelWidth + 30, height: nameLabelHeight + 8)
    }
    
    // MARK: - Private
    
    private func setupViews() {
        alphaView.layer.cornerRadius = 10
        containerView.layer.cornerRadius = 10
    }
}
