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
        tv.separatorStyle = .none
        tv.backgroundColor = UIColor(hex: "#2A85ECFF")
        tv.contentInset = .init(top: 0, left: 0, bottom: UIView.bottomInsetHeight, right: 0)
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
        
        title = "Bike Finder"
        
        registerTableViewCells()
        setupView()
        
        viewModel.requestData {
            self.tableView.reloadData()
        }
    }
}

// MARK: UI Helpers

extension HomeViewController {
    
    private func setupView() {
        view.addSubview(tableView)
        tableView.activateEdgeConstraints(useBottomSafeAreaLayout: false)
    }
    
    private func registerTableViewCells() {
        tableView.register(CountryNetworksTableViewCell.self, forCellReuseIdentifier: CountryNetworksTableViewCell.identifier)
    }
}

extension HomeViewController: UITableViewDelegate {}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.networkList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryNetworksTableViewCell.identifier, for: indexPath) as! CountryNetworksTableViewCell
        let section = viewModel.networkList[indexPath.section]
        cell.configure(forCountry: section.sectionFlag, networks: section.sectionNetworks)
        return cell
    }
}

