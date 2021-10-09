//

import Foundation

protocol EventsProviderProtocol {
    typealias EventsListCompletion = (Result<[EventModel], UseCaseError>) -> Void

    func getEvents(completion: @escaping EventsListCompletion)
}
