import IGListKit
import UIKit

final class MovieCellAdapterCreator: BaseInteractiveAdapterCreator<Movie, MovieCellAdapter> {}

struct ClaimCellAdapterHandler {
    let onClick: Action<Movie>?
}

final class MovieCellAdapter: ListSectionController, Interactable {
    typealias Handler = ClaimCellAdapterHandler
    var handler: Handler?

    private var item: Movie!

    public override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = dequeueReusableCell(cellType: MovieCell.self, at: index)
        cell.onDetailClick = handler?.onClick
        return cell.configure(self.item)
    }

    public override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext!.containerSize.width - 10
        let height = collectionContext!.containerSize.height / 2 + 200
        return CGSize(width: width, height: height)
    }

    public override func didUpdate(to object: Any) {
        self.item = object as? Movie
    }
}
