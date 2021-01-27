//
//  HomeViewController.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import UIKit

private class Constants {
    static let activityIndicatorFrame: CGRect = CGRect(x: 0, y: 0, width: 20, height: 20)
    static let tableViewContentInsets: UIEdgeInsets = .init(top: 0,
                                                            left: 0,
                                                            bottom: UIView.bottomInsetHeight,
                                                            right: 0)
}

final class HomeViewController: UIViewController {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(frame: Constants.activityIndicatorFrame)
        ai.color = .white
        return ai
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = AppColors.dividerColor
        tv.contentInset = Constants.tableViewContentInsets
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
        
        viewModel.store.delegate = self
        
        title = viewModel.viewTitle
        
        setupNavigationBar()
        registerTableViewCells()
        setupView()
        getData()
    }
}

// MARK: - Data Helpers

extension HomeViewController {
    
    private func getData() {
        activityIndicator.startAnimating()
        viewModel.requestData { [weak self] (error) in
            if let error = error {
                Toast.showHint(type: .error, messageTitle: error.localizedDescription, actionTitle: "DISMISS")
            }
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - UI Helpers

extension HomeViewController {
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.tintColor = AppColors.textPrimaryColor
        navigationController?.navigationBar.barTintColor = AppColors.primaryColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: AppColors.textPrimaryColor ?? .white]
        
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
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

// MARK: - DataStoreDelegate

extension HomeViewController: DataStoreDelegate {
    
    func errorOccurred(error: Error) {
        Toast.showHint(type: .error, messageTitle: error.localizedDescription, actionTitle: "DISMISS")
    }
}
