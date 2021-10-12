import Foundation
import UIKit

final class EventsDIContainer {
    // MARK: - Events List
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
    
    // MARK: - Events Details
    func buildEventDetailsViewController(eventModel: EventModel) -> EventDetailsViewController {
        return EventDetailsViewController.create(with: buildEventDetailsViewModel(event: eventModel))
    }
    
    func buildEventDetailsViewModel(event: EventModel) -> EventDetailsViewModel {
        return DefaultEventDetailsViewModel(event: event)
    }
    
    // MARK: - Flow Coordinators
    func buildEventsListFlowCoordinator(navigationController: UINavigationController) -> EventsListFlowCoordinator {
        return EventsListFlowCoordinator(navigationController: navigationController, dependencies: self)
        
    }
}

extension EventsDIContainer: EventsListFlowCoordinatorDependencies {}
