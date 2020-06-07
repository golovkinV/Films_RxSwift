import IGListKit
import UIKit

final class GenreCellAdapterCreator: BaseInteractiveAdapterCreator<Genre, GenreCellAdapter> {}

struct GenreCellAdapterHandler {}

final class GenreCellAdapter: ListSectionController, Interactable {
    typealias Handler = GenreCellAdapterHandler
    var handler: Handler?

    private var item: Genre!

    public override func sizeForItem(at index: Int) -> CGSize {
        return GenreCell.sizeForCell(item)
    }
    
    public override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = dequeueReusableCell(cellType: GenreCell.self, at: index)
        return cell.configure(self.item)
    }

    public override func didUpdate(to object: Any) {
        self.item = object as? Genre
    }
}
