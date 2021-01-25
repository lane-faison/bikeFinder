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
        tv.backgroundColor = .clear
        tv.estimatedRowHeight = 100
        tv.rowHeight = UITableView.automaticDimension
        tv.contentInset = .init(top: 12, left: 0, bottom: UIView.bottomInsetHeight, right: 0)
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
        view.backgroundColor = .lightGray
        
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
        tableView.register(NetworkTableViewCell.self, forCellReuseIdentifier: "networkCell")
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.networkList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.networkList[section].sectionNetworks.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "networkCell", for: indexPath) as! NetworkTableViewCell
        cell.configure(withNetwork: viewModel.networkList[indexPath.section].sectionNetworks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.networkList[section].sectionName
    }
}

