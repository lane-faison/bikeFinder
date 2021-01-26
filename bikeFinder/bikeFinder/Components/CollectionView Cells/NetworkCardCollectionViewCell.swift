//
//  NetworkCardCollectionViewCell.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/24/21.
//

import UIKit

final class NetworkCardCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: self)
    
    private let nameLabel: UILabel = {
        let l = UILabel()
        l.font = AppFonts.title
        l.textColor = AppColors.primaryTextColor
        l.backgroundColor = AppColors.accentColor
        l.textAlignment = .center
        l.numberOfLines = 1
        return l
    }()
    
    private let companyLabel: UILabel = {
        let l = UILabel()
        l.font = AppFonts.subtitle
        l.textColor = AppColors.secondaryTextColor
        l.textAlignment = .left
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
    
    override var isHighlighted: Bool {
        didSet {
            contentView.layer.borderWidth = isHighlighted ? 2 : 1
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        let companyStack = horizontalStack(spacer(), listIconImageView(for: AppImages.business).withDimension(14), companyLabel, spacer(), spacing: 4, alignment: .leading)
        let locationStack = horizontalStack(spacer(), listIconImageView(for: AppImages.locationMarker).withDimension(14), cityLabel, spacer(), spacing: 4, alignment: .leading)
        let mainStack = verticalStack(nameLabel.withHeight(30), companyStack, locationStack, spacing: 4, distribution: .equalSpacing)
        
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
        companyLabel.text = network.company?.joined(separator: ",")
        cityLabel.text = network.city
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        companyLabel.text = nil
        cityLabel.text = nil
    }
}

// MARK: - UI Helpers

extension NetworkCardCollectionViewCell {
    
    private func spacer() -> UIView {
        return UIView().withWidth(4)
    }
    
    private func listIconImageView(for icon: UIImage) -> UIImageView {
        let iv = UIImageView()
        iv.image = icon.withTintColor(AppColors.secondaryTextColor ?? .gray)
        iv.contentMode = UIView.ContentMode.scaleAspectFit
        return iv
    }
}
