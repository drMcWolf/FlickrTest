//
//  SearchHistoryView.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 24.05.2022.
//

import UIKit

protocol SearchHistoryViewDelegate: AnyObject {
    func selectItem(at index: Int)
}

final class SearchHistoryView: UIView {
    private struct Constants {
        static let identifier = String(describing: UITableViewCell.self)
    }
    private weak var delegate: SearchHistoryViewDelegate?
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.identifier)
        return tableView
    }()
    private var viewModel: ViewModel?
    
    init(with delegate: SearchHistoryViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SearchHistoryView {
    func addSubviews() {
        addSubview(tableView)
    }
    
    func makeConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension SearchHistoryView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: Constants.identifier)//tableView.dequeueReusableCell(withIdentifier: Constants.identifier, for: indexPath)
        if let cellViewModel = viewModel?.items[indexPath.row] {
            cell.configure(with: cellViewModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectItem(at: indexPath.row)
    }
}

extension SearchHistoryView: Configurable {
    struct ViewModel {
        let items: [UITableViewCell.ViewModel]
    }
    
    func configure(with viewModel: ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
}

extension UITableViewCell: Configurable {
    struct ViewModel {
        let title: String
        let details: String
    }
    
    func configure(with viewModel: ViewModel) {
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.details
    }
}
