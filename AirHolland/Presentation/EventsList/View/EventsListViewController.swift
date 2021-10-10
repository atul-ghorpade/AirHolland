//

import UIKit

final class EventsListViewController: UIViewController, StoryboardInstantiable, Alertable {
    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel: EventsListViewModel!

    static func create(with viewModel: EventsListViewModel) -> EventsListViewController {
        let view = EventsListViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
        viewModel.viewLoaded()
    }
    
    private func setupViews() {
        tableView.register(UINib(nibName: EventCell.identifier, bundle: nil), forCellReuseIdentifier: EventCell.identifier)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func bind(to viewModel: EventsListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
}

extension EventsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier,
                                                       for: indexPath) as? EventCell else {
            assertionFailure("Cannot dequeue reusable cell \(EventCell.self) with reuseIdentifier: \(EventCell.identifier))")
            return UITableViewCell()
        }

        cell.fill(with: viewModel.items.value[indexPath.row])
        return cell
    }
}
