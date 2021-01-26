//
//  HomeViewController.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = AppColors.dividerColor
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
        
        title = viewModel.viewTitle
        
        setupNavigationBar()
        registerTableViewCells()
        setupView()
        
        viewModel.requestData {
            self.tableView.reloadData()
        }
    }
}

// MARK: UI Helpers

extension HomeViewController {
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.tintColor = AppColors.textPrimaryColor
        navigationController?.navigationBar.barTintColor = AppColors.primaryColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: AppColors.textPrimaryColor ?? .white]
    }
    
    private func registerTableViewCells() {
        tableView.register(CountryNetworksTableViewCell.self, forCellReuseIdentifier: CountryNetworksTableViewCell.identifier)
    }
    
    private func setupView() {
        view.addSubview(tableView)
        tableView.activateEdgeConstraints(useBottomSafeAreaLayout: false)
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNetworkList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryNetworksTableViewCell.identifier, for: indexPath) as! CountryNetworksTableViewCell
        let section = viewModel.getNetworkList[indexPath.section]
        cell.configure(forCountry: section.sectionFlag, networks: section.sectionNetworks)
        cell.delegate = self
        return cell
    }
}

// MARK: - CountryNetworkCellDelegate

extension HomeViewController: CountryNetworkCellDelegate {
    
    func bikeNetworkTapped(at index: Int, inNetworks networks: [BikeNetwork]) {
        let mapVM = MapViewModel(bikeNetworks: networks, highlightedNetworkIndex: index)
        let mapVC = MapViewController.instantiate(with: mapVM)
        navigationController?.pushViewController(mapVC, animated: true)
    }
}
