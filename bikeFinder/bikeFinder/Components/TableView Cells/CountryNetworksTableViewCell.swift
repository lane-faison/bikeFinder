//
//  CountryNetworksTableViewCell.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import UIKit

final class CountryNetworksTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: self)
    
    private let countryLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    private let container: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        return v
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.contentInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        cv.register(NetworkCardCollectionViewCell.self, forCellWithReuseIdentifier: NetworkCardCollectionViewCell.identifier)
        return cv
    }()
    
    private var networks: [BikeNetwork] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(container)
        container.activateEdgeConstraints(withEdgeInsets: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        container.addSubview(countryLabel)
        countryLabel.anchor(top: container.topAnchor, left: container.leadingAnchor, insets: .init(top: 10, left: 10, bottom: 0, right: 0), height: 30)
        
        container.addSubview(collectionView)
        collectionView.anchor(top: countryLabel.bottomAnchor, left: container.leadingAnchor, bottom: container.bottomAnchor, right: container.trailingAnchor, insets: .init(top: 0, left: 0, bottom: 10, right: 0), height: 100)
    }
    
    func configure(forCountry country: String, networks: [BikeNetwork]) {
        self.countryLabel.text = country
        self.networks = networks
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        networks.removeAll()
        countryLabel.text = nil
        
    }
}

// MARK: UICollectionViewDataSource

extension CountryNetworksTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return networks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NetworkCardCollectionViewCell.identifier, for: indexPath) as! NetworkCardCollectionViewCell
        print("Index: \(indexPath.row) - Total: \(networks.count)")
        cell.configure(with: networks[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CountryNetworksTableViewCell: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegate

extension CountryNetworksTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 100)
    }
}
