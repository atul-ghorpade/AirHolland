//

import UIKit

final class EventsListViewController: UIViewController, StoryboardInstantiable, Alertable {
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
        
    }
    
    private func bind(to viewModel: EventsListViewModel) {
        viewModel.items?.observe(on: self) { [weak self] _ in
            //
        }
    }
}
