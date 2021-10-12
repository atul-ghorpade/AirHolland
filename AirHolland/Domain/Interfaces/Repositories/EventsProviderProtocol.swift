//

import Foundation

protocol EventsProviderProtocol {
    typealias EventsListCompletion = (Result<[EventModel], UseCaseError>) -> Void

    func getEvents(shouldRefreshExplicitly: Bool, completion: @escaping EventsListCompletion)
}
