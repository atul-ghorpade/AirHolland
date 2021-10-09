//

import Foundation

struct EventsListViewModelActions {
    let showEventDetails: (EventModel) -> Void
}

protocol EventsListViewModelInput {
    func viewLoaded()
}

protocol EventsListViewModelOutput {
    var items: Observable<[EventItemViewModel]>? { get }
    var screenTitle: String { get }
}

protocol EventsListViewModel: EventsListViewModelInput, EventsListViewModelOutput {}

final class DefaultEventsListViewModel: EventsListViewModel {
    private let getEventsUseCase: GetEventsUseCase
    private let actions: EventsListViewModelActions
    
    init(eventsListUseCase: GetEventsUseCase,
         actions: EventsListViewModelActions) {
        self.getEventsUseCase = eventsListUseCase
        self.actions = actions
    }
    
    func viewLoaded() {
        getEventsUseCase.run(GetEventsParams() { [weak self] result in
            switch result {
            case let .success(eventModels):
                break
            case .failure:
                break
            }
        })
    }
    
    var items: Observable<[EventItemViewModel]>?
    
    var screenTitle: String = ""
}
