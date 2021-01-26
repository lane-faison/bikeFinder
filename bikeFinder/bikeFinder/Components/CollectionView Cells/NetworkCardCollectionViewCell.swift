//
//  NetworkCardCollectionViewCell.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/24/21.
//

import UIKit

final class NetworkCardCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: self)
    
    private let placeMarkerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = AppImages.locationMarker.withTintColor(AppColors.secondaryTextColor ?? .gray)
        iv.contentMode = UIView.ContentMode.scaleAspectFit
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let l = UILabel()
        l.font = AppFonts.title
        l.textColor = AppColors.primaryTextColor
        l.backgroundColor = AppColors.accentColor
        l.textAlignment = .center
        l.numberOfLines = 2
        return l
    }()
    
    private let cityLabel: UILabel = {
        let l = UILabel()
        l.font = AppFonts.subtitle
        l.textColor = AppColors.secondaryTextColor
        l.textAlignment = .left
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
        let spacer = UIView().withWidth(4)
        let locationStack = horizontalStack(spacer, placeMarkerImageView.withDimension(14), cityLabel, spacing: 4, alignment: .leading, distribution: .fill)
        let mainStack = verticalStack(nameLabel.withHeight(40), locationStack, distribution: .equalCentering)
        
        contentView.addSubview(mainStack)
        mainStack.activateEdgeConstraints(withEdgeInsets: .init(top: 0, left: 0, bottom: 10, right: 0))
        
        contentView.layer.cornerRadius = 10.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.masksToBounds = true
        contentView.layer.backgroundColor = UIColor.white.cgColor
    }
    
    
    func configure(with network: BikeNetwork) {
        nameLabel.text = network.networkName
        cityLabel.text = network.city
        cityLabel.sizeToFit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        cityLabel.text = nil
    }
}
