//

import Foundation

protocol EventsListViewModelInput {
    func viewLoaded()
}

protocol EventsListViewModelOutput {
    var items: Observable<[EventItemViewModel]>? { get }
    var screenTitle: String { get }
}

protocol EventsListViewModel: EventsListViewModelInput, EventsListViewModelOutput {}

final class DefaultEventsListViewModel: EventsListViewModel {
    func viewLoaded() {
    }
    
    var items: Observable<[EventItemViewModel]>?
    
    var screenTitle: String = ""
}
