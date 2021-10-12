//

import Foundation

struct EventsListViewModelActions {
    let showEventDetails: (EventModel) -> Void
}

protocol EventsListViewModelInput {
    func viewLoaded()
    func listRefreshRequested()
}

protocol EventsListViewModelOutput {
    var items: Observable<[EventsSectionViewModel]> { get }
    var error: Observable<String> { get }
    var screenTitle: String { get }
}

protocol EventsListViewModel: EventsListViewModelInput, EventsListViewModelOutput {}

final class DefaultEventsListViewModel: EventsListViewModel {
    private let getEventsUseCase: GetEventsUseCase
    private let actions: EventsListViewModelActions
    
    var items: Observable<[EventsSectionViewModel]> = Observable([])
    var error: Observable<String> = Observable("")
    var screenTitle: String = ""

    init(eventsListUseCase: GetEventsUseCase,
         actions: EventsListViewModelActions) {
        self.getEventsUseCase = eventsListUseCase
        self.actions = actions
    }
    
    func viewLoaded() {
        getEventsUseCase.run(GetEventsParams() { [weak self] result in
            self?.handleEventsListResponse(result: result)
        })
    }
    
    func listRefreshRequested() {
        getEventsUseCase.run(GetEventsParams(shouldRefreshExplicitly: true) { [weak self] result in
            self?.handleEventsListResponse(result: result)
        })
    }
    
    func handleEventsListResponse(result: Result<[EventModel], UseCaseError>) {
        switch result {
        case let .success(eventModels):
            items.value = createSectionsViewModels(events: eventModels)
        case .failure:
            error.value = "Oops! Error while fetching events"
        }
    }
    
    private func createSectionsViewModels(events: [EventModel]) -> [EventsSectionViewModel] {
        guard events.count > 0 else {
            return []
        }
        let sortedEvents = events.sorted {
            $0.date < $1.date
        }
        let datesArray = events.map {
            $0.date
        }
        let uniqueDatesArray = datesArray.uniqued()
        return uniqueDatesArray.map { uniqueDate in
            let eventsArrayWithDate = sortedEvents.filter {
                $0.date == uniqueDate
            }
            let sectionTitleString = uniqueDate.toString(format: .custom("EEEE, dd MMMM, yyyy"))
            let eventItemViewModels = eventsArrayWithDate.map {
                EventItemViewModel($0)
            }

            return EventsSectionViewModel(title: sectionTitleString,
                                                              rows: eventItemViewModels)
        }
    }
}

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}
