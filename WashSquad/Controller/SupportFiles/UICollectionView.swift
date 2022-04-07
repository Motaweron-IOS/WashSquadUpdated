//
//  UICollectionView.swift
//  PizzaWorldOne
//
//  Created by Ghoost on 10/14/20.
//

import UIKit

extension UICollectionView {
    
    func reload() {
        DispatchQueue.main.async {
            self.reloadData()
    }}
    
    func registerCell<Cell: UICollectionViewCell>(cellClass: Cell.Type){
        //MARK: Generic Register cells
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: Cell.self))
    }
    
    
    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell{
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Error in cell")
        }
        return cell
    }
    
    func registerHeaderFooter<Cell: UICollectionReusableView>(cellClass: Cell.Type, kind: String){
        //MARK: Generic Register Header (Header/Footer)
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: Cell.self))
    }
    
    //    UICollectionView.elementKindSectionHeader
    
    func dequeueHeaderFooter<Cell: UICollectionReusableView>(kind: String, indexPath:IndexPath) -> Cell{
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Error in cell")
        }
        return cell
    }

    
    func setCollectionLayOut(_ height:Int,_ count:Int,scrollDirection: ScrollDirection){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.bounds.width - CGFloat(5 * (count + 1)))/CGFloat(count), height: CGFloat(height - 4))
        layout.scrollDirection = scrollDirection
        self.collectionViewLayout  = layout
    }

    func autoWidthSize(_ vc:UIViewController,_ title:String?){
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.itemSize =  CGSize(width: title?.size(withAttributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]).width ?? 0 + 50, height: self.frame.height - 5)
        layout.scrollDirection = .horizontal
        self.collectionViewLayout  = layout
    }
   
    
}
class RTLCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
    override var developmentLayoutDirection: UIUserInterfaceLayoutDirection {
        return UIUserInterfaceLayoutDirection.leftToRight
    }
}
class AutoSizedCollectionView: UICollectionView {

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
extension UICollectionView {
  var visibleCurrentCellIndexPath: IndexPath? {
    for cell in self.visibleCells {
      let indexPath = self.indexPath(for: cell)
      return indexPath
    }
    
    return nil
  }
    
    func moveToNextCell(indexPath:IndexPath) {
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func setFirstCellSelected() {
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        self.selectItem(at: selectedIndexPath, animated: true, scrollPosition: [])
    }
    
}
