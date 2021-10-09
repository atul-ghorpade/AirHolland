import UIKit

protocol EventsListFlowCoordinatorDependencies {
    func buildEventsListViewController(actions: EventsListViewModelActions) -> EventsListViewController
}

final class EventsListFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: EventsListFlowCoordinatorDependencies

    private weak var eventsListVC: EventsListViewController?
    
    init(navigationController: UINavigationController,
         dependencies: EventsListFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = EventsListViewModelActions(showEventDetails: showEventDetails)
        let vc = dependencies.buildEventsListViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: false)
        eventsListVC = vc
    }
    
    private func showEventDetails(eventModel: EventModel) {
        // TODO: navigate to details
    }
}
