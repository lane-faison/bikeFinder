//
//  HomeViewController.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import UIKit


class HomeViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    private var viewModel: HomeViewModel!
    
    static func instantiate() -> HomeViewController {
        let vc = HomeViewController()
        vc.viewModel = HomeViewModel()
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Bike Finder"
        
        viewModel.fetchData { (error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        registerTableViewCells()
        setupView()
    }
}

// MARK: UI Helpers

extension HomeViewController {
    
    private func setupView() {
        view.addSubview(tableView)
        tableView.activateEdgeConstraints()
    }
    
    private func registerTableViewCells() {
        tableView.register(NetworkTableViewCell.self, forCellReuseIdentifier: "networkCell")
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.networks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < viewModel.networks.count {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "networkCell", for: indexPath) as? NetworkTableViewCell {
                cell.configure(withNetwork: viewModel.networks[indexPath.row])
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            return UITableViewCell()
        }
    }
}

