//

import UIKit

final class EventsListViewController: UIViewController, StoryboardInstantiable, Alertable {
    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel: EventsListViewModel!
    private lazy var refreshControl = UIRefreshControl()
    
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
        title = viewModel.screenTitle
        tableView.register(UINib(nibName: EventCell.identifier, bundle: nil), forCellReuseIdentifier: EventCell.identifier)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    private func bind(to viewModel: EventsListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
        viewModel.error.observe(on: self) { [weak self] error in
            guard !error.isEmpty else {
                return
            }
            self?.refreshControl.endRefreshing()
            self?.showAlert(message: error)
        }
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        viewModel.listRefreshPulled()
    }
}

extension EventsListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        headerView.backgroundColor = .systemGroupedBackground

        let titleLabel = UILabel(frame: CGRect(x: 10, y: 7, width: view.frame.size.width, height: 36))
        titleLabel.text = viewModel.items.value[section].title
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        headerView.addSubview(titleLabel)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionViewModel = viewModel.items.value[section]
        return sectionViewModel.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier,
                                                       for: indexPath) as? EventCell else {
            assertionFailure("Cannot dequeue reusable cell \(EventCell.self) with reuseIdentifier: \(EventCell.identifier))")
            return UITableViewCell()
        }

        let sectionViewModel = viewModel.items.value[indexPath.section]
        let rowViewModel = sectionViewModel.rows[indexPath.row]
        cell.fill(with: rowViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedRow(section: indexPath.section,
                              row: indexPath.row)
    }
}
