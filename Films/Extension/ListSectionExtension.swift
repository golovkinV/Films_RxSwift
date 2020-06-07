import IGListKit

extension ListSectionController {
    func dequeueReusableCell<T: UICollectionViewCell>(cellType: T.Type, at index: Int) -> T {
        let cell = self.collectionContext?.dequeueReusableCell(withNibName: cellType.className(),
                                                               bundle: nil,
                                                               for: self,
                                                               at: index) as? T
        return cell!
    }
}

