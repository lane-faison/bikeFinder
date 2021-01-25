//
//  NetworkCardCollectionViewCell.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/24/21.
//

import UIKit

class NetworkCardCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "NetworkCardCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "NetworkCardCollectionViewCell", bundle: nil)
    }
    
    private let nameLabel: UILabel = {
        let l = UILabel()
        l.font = AppFonts.title
        l.numberOfLines = 2
        return l
    }()
    
    private let cityLabel: UILabel = {
        let l = UILabel()
        l.font = AppFonts.subtitle
        l.textColor = .gray
        l.numberOfLines = 2
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        let vStack = verticalStack(nameLabel, cityLabel, alignment: .center, distribution: .equalSpacing)
        contentView.addSubview(vStack)
        vStack.activateEdgeConstraints(withEdgeInsets: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        contentView.layer.cornerRadius = 4.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.masksToBounds = true
        contentView.layer.backgroundColor = UIColor.white.cgColor
    }
    
    
    func configure(with network: BikeNetwork) {
        nameLabel.text = network.networkName
        cityLabel.text = network.city
    }
}
