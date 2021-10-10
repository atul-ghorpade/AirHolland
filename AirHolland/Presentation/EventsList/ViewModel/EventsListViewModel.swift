//

import Foundation

struct EventsListViewModelActions {
    let showEventDetails: (EventModel) -> Void
}

protocol EventsListViewModelInput {
    func viewLoaded()
}

protocol EventsListViewModelOutput {
    var items: Observable<[EventItemViewModel]> { get }
    var screenTitle: String { get }
}

protocol EventsListViewModel: EventsListViewModelInput, EventsListViewModelOutput {}

final class DefaultEventsListViewModel: EventsListViewModel {
    private let getEventsUseCase: GetEventsUseCase
    private let actions: EventsListViewModelActions
    
    var items: Observable<[EventItemViewModel]> = Observable([])
    var screenTitle: String = ""

    init(eventsListUseCase: GetEventsUseCase,
         actions: EventsListViewModelActions) {
        self.getEventsUseCase = eventsListUseCase
        self.actions = actions
    }
    
    func viewLoaded() {
        getEventsUseCase.run(GetEventsParams() { [weak self] result in
            switch result {
            case let .success(eventModels):
                self?.items.value = eventModels.map {
                    EventItemViewModel($0)
                }
            case .failure:
                break
            }
        })
    }
}
