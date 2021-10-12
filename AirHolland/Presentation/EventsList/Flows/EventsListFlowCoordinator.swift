import UIKit

protocol EventsListFlowCoordinatorDependencies {
    func buildEventsListViewController(actions: EventsListViewModelActions) -> EventsListViewController
    func buildEventDetailsViewController(eventModel: EventModel) -> EventDetailsViewController
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
        let vc = dependencies.buildEventDetailsViewController(eventModel: eventModel)
        navigationController?.pushViewController(vc, animated: false)
    }
}
