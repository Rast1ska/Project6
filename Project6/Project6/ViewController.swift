//
//  ViewController.swift
//  Project6
//
//  Created by Ильфат Салахов on 26.01.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: -Private Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    // MARK: -Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tableView.dataSource = self
    }
    
    // MARK: -Privaete Methods
    private func setupView() {
        addSubview()
        setupConstraints()
        setupNavigationController()
        view.backgroundColor = .white
        title = "Shopping list"
    }
    
    private func addSubview() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}


// MARK: - UITableViewDataSource
extension UIViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
}



