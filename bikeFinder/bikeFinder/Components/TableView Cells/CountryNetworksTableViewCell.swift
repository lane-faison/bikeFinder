//
//  CountryNetworksTableViewCell.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import UIKit

protocol CountryNetworkCellDelegate: class {
    func bikeNetworkTapped(at index: Int, inNetworks networks: [BikeNetwork])
}

private class Constants {
    static let cardSize: CGSize = .init(width: 150, height: 100)
    static let collectionViewHeight: CGFloat = 100
    static let collectionViewInsets: UIEdgeInsets = .init(top: 0, left: 0, bottom: 10, right: 0)
    static let collectionViewContentInsets: UIEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)
    static let containerInsets: UIEdgeInsets = .init(top: 0, left: 0, bottom: 10, right: 0)
    static let countryLabelInsets: UIEdgeInsets = .init(top: 10, left: 10, bottom: 0, right: 0)
    static let countryLabelHeight: CGFloat = 30
}

final class CountryNetworksTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: self)
    
    private let countryLabel: UILabel = {
        let l = UILabel()
        l.font = AppFonts.largeTitle
        l.textColor = AppColors.primaryTextColor
        return l
    }()
    
    private let container: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = Constants.collectionViewContentInsets
        cv.register(NetworkCardCollectionViewCell.self, forCellWithReuseIdentifier: NetworkCardCollectionViewCell.identifier)
        return cv
    }()
    
    private var networks: [BikeNetwork] = []
    
    weak var delegate: CountryNetworkCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(forCountry country: String, networks: [BikeNetwork]) {
        self.countryLabel.text = country
        self.networks = networks
        collectionView.reloadData()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        networks.removeAll()
        countryLabel.text = nil
    }
}

// MARK: - UI Helpers

extension CountryNetworksTableViewCell {
    
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(container)
        container.activateEdgeConstraints(withEdgeInsets: Constants.containerInsets)
        
        container.addSubview(countryLabel)
        countryLabel.anchor(top: container.topAnchor,
                            left: container.leadingAnchor,
                            insets: Constants.countryLabelInsets,
                            height: Constants.countryLabelHeight)
        
        container.addSubview(collectionView)
        collectionView.anchor(top: countryLabel.bottomAnchor,
                              left: container.leadingAnchor,
                              bottom: container.bottomAnchor,
                              right: container.trailingAnchor,
                              insets: Constants.collectionViewInsets,
                              height: Constants.collectionViewHeight)
    }
}

// MARK: - UICollectionViewDataSource

extension CountryNetworksTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return networks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NetworkCardCollectionViewCell.identifier, for: indexPath) as! NetworkCardCollectionViewCell
        cell.configure(with: networks[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CountryNetworksTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.bikeNetworkTapped(at: indexPath.row, inNetworks: networks)
    }
}

// MARK: - UICollectionViewDelegate

extension CountryNetworksTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.cardSize
    }
}
