//
//  NetworkCardCollectionViewCell.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/24/21.
//

import UIKit

private class Constants {
    static let iconDimension: CGFloat = 14
    static let nameLabelHeight: CGFloat = 30
    static let mainStackInsets: UIEdgeInsets = .init(top: 0, left: 0, bottom: 10, right: 0)
    static let cardCornerRadius: CGFloat = 10
    static let borderWidth: CGFloat = 1
    static let highlightedBorderWidth: CGFloat = 2
    static let spacing: CGFloat = 4
}

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
            contentView.layer.borderWidth = isHighlighted ? Constants.highlightedBorderWidth : Constants.borderWidth
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func setupCell() {
        let companyStack = horizontalStack(spacer(), listIconImageView(for: AppImages.business).withDimension(Constants.iconDimension), companyLabel, spacer(), spacing: Constants.spacing, alignment: .leading)
        let locationStack = horizontalStack(spacer(), listIconImageView(for: AppImages.locationMarker).withDimension(Constants.iconDimension), cityLabel, spacer(), spacing: Constants.spacing, alignment: .leading)
        let mainStack = verticalStack(nameLabel.withHeight(Constants.nameLabelHeight), companyStack, locationStack, spacing: Constants.spacing, distribution: .equalSpacing)
        
        contentView.addSubview(mainStack)
        mainStack.activateEdgeConstraints(withEdgeInsets: Constants.mainStackInsets)
        
        contentView.layer.cornerRadius = Constants.cardCornerRadius
        contentView.layer.borderWidth = Constants.borderWidth
        contentView.layer.borderColor = AppColors.dividerColor?.cgColor
        contentView.layer.masksToBounds = true
        contentView.layer.backgroundColor = UIColor.white.cgColor
    }
    
    private func spacer() -> UIView {
        return UIView().withWidth(Constants.spacing)
    }
    
    private func listIconImageView(for icon: UIImage) -> UIImageView {
        let iv = UIImageView()
        iv.image = icon.withTintColor(AppColors.secondaryTextColor ?? .gray)
        iv.contentMode = UIView.ContentMode.scaleAspectFit
        return iv
    }
}
