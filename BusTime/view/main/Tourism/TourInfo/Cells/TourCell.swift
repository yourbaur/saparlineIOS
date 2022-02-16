//
//  TourCell.swift
//  SaparLine
//
//  Created by Cheburek on 12.02.2022.
//  Copyright © 2022 thousand.com. All rights reserved.
//

import UIKit
import SnapKit

final class TourCell: UITableViewCell {
    
    static let identifier = "TourCell"
    
    public var isDeselectionAllowed: Bool = false

    public var isSelectionAllowed: Bool? {
        didSet {
            collectionView.allowsSelection = isSelectionAllowed!
            collectionView.reloadData()
        }
    }

    public var selectedCellIndex: IndexPath? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public var didSelectIndex: ((IndexPath) -> Void)?
    public var didSelectOrDeselectIndex: ((IndexPath?) -> Void)?
    
    //Haptic feedback
    private var selection = UISelectionFeedbackGenerator()

//    public var items = [DisplaybleBundle]() {
//        didSet {
//            collectionView.reloadData()
//
//            //set text with description at the bottom of self
//            subLabel.text = items[safe: selectedCellIndex?.row ?? 0]?.description ?? ""
//        }
//    }

    var gradientLayer: CAGradientLayer?

    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
//        layout.itemSize = CGSize(width: 150, height: 84)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 16
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(TourImagesCell.self, forCellWithReuseIdentifier: TourImagesCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceHorizontal = true
//        collectionView.layer.cornerRadius = 10
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 10
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
//        backgroundColor = .iziSystemBackground
        contentView.addSubview(collectionView)
        updateConstraints()
    }

    private func setupConstraints() {
        collectionView.snp.updateConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.size.height / 4.5)
        }
    }

}

extension TourCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TourImagesCell.identifier, for: indexPath) as! TourImagesCell
        
//        if let item = items[safe: indexPath.row] {
//            cell.label.text = item.title
//            cell.subLabel.text = item.subtitle
//        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard isSelectionAllowed == true else { return }
        cell.isSelected = selectedCellIndex?.row == indexPath.row
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selection.selectionChanged()
        
        if isDeselectionAllowed == true && selectedCellIndex == indexPath {
            selectedCellIndex = nil
        } else {
            selectedCellIndex = indexPath
        }
        
        if let didSelectOrDeselectIndex = self.didSelectOrDeselectIndex {
            didSelectOrDeselectIndex(selectedCellIndex)
        }
        
        if let didSelectIndex = self.didSelectIndex {
            didSelectIndex(indexPath)
        }

        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
//        if let item = items[safe: selectedCellIndex?.row ?? 0] {
//            subLabel.text = item.description
//        }
    }
    
    
}

extension TourCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width - 60, height: UIScreen.main.bounds.size.height / 4.5)
    }
}
