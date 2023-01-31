//
//  ViewController.swift
//  Project6
//
//  Created by Ильфат Салахов on 26.01.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: -Private Properties
    private var shoppingList = [String]()
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewProduct))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(refreshResult))
    }
    
    @objc private func addNewProduct() {
        showAlertController(title: "Что вы хотите купить?", message: "Введите продукт, который вы хожите добавить в список")
    }
    
    @objc private func refreshResult() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    private func submit(_ product: String) {
        if !product.isEmpty {
            if !shoppingList.contains(product) {
                shoppingList.insert(product, at: 0)
                let indexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
                return
            } else {
                showAlertControllerError(title: "Ошибка!", message: "Такой продукт уже есть!")
            }
        } else {
            showAlertControllerError(title: "Ошибка!", message: "Введите корректные данные!")
        }
    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(shoppingList[indexPath.row])
        return cell
    }
}

// MARK: -UIAlertController
extension ViewController {
    func showAlertController(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Write..."
        }
        
        let actionOK = UIAlertAction(title: "Add", style: .default) { [weak self, weak alertController] action in
            guard let product = alertController?.textFields?.first?.text else { return }
            self?.submit(product)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .destructive)
        
        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)
        present(alertController, animated: true)
    }
    
    func showAlertControllerError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(actionOK)
        present(alertController, animated: true)
    }
}

// Нужно сделать анимацию добавления нового продукта
// Поработать с  UIActivityViewController, чтобы можно было передать список продуктов

