//
//  EventsProviderMock.swift
//  AirHollandTests
//
//  Created by Atul Ghorpade on 14/10/21.
//

import Foundation
@testable import AirHolland

final class EventsProviderMock: EventsProviderProtocol {
    var result: Result<[EventModel], UseCaseError>?

    func getEvents(shouldRefreshExplicitly: Bool, completion: @escaping EventsListCompletion) {
        guard let result = result else {
            fatalError("Result not provided")
        }
        completion(result)
    }
}
