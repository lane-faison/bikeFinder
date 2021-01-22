//
//  NetworkTableViewCell.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import UIKit

final class NetworkTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
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
    
    func configure(withNetwork network: Network) {
        titleLabel.text = network.name
    }
    
    private func setupCell() {
        contentView.addSubview(titleLabel)
        titleLabel.activateEdgeConstraints()
    }
}
