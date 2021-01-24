//
//  NetworkTableViewCell.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import UIKit

final class NetworkTableViewCell: UITableViewCell {
    
    private let container: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 12
        return v
    }()
    
    private let nameLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    private let idLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    private let companyLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    private let locationLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    private let countryLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    private let coordinateLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withNetwork network: BikeNetwork) {
        nameLabel.text = network.networkName
        idLabel.text = network.id
        companyLabel.text = network.company?[0] ?? "N/A"
        locationLabel.text = "\(network.city ?? ""), \(network.country ?? "")"
        coordinateLabel.text = "lat: \(network.latitude), long: \(network.longitude)"
    }
    
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = .clear
        
        let stack = verticalStack(nameLabel, idLabel, companyLabel, locationLabel, coordinateLabel, spacing: 4, alignment: .leading, distribution: .fill)
        container.addSubview(stack)
        stack.activateEdgeConstraints(withEdgeInsets: .init(top: 12, left: 12, bottom: 12, right: 12))
        
        contentView.addSubview(container)
        container.activateEdgeConstraints(withEdgeInsets: .init(top: 0, left: 12, bottom: 12, right: 12))
    }
}
