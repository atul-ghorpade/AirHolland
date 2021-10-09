import Foundation
import UIKit

final class EventsDIContainer {
    func buildEventsListViewController(actions: EventsListViewModelActions) -> EventsListViewController {
        return EventsListViewController.create(with: buildEventsListViewModel(actions: actions))
    }
    
    func buildEventsListViewModel(actions: EventsListViewModelActions) -> EventsListViewModel {
        return DefaultEventsListViewModel(eventsListUseCase: buildEventsListUseCase(), actions: actions)
    }
    
    func buildEventsListUseCase() -> GetEventsUseCase {
        return DefaultGetEventsUseCase(provider: buildEventsListProvider())
        
    }
    
    func buildEventsListProvider() -> EventsProviderProtocol {
        return DefaultEventsProvider()
    }
    
    // MARK: - Flow Coordinators
    func buildEventsListFlowCoordinator(navigationController: UINavigationController) -> EventsListFlowCoordinator {
        return EventsListFlowCoordinator(navigationController: navigationController, dependencies: self)
        
    }
}

extension EventsDIContainer: EventsListFlowCoordinatorDependencies {}
