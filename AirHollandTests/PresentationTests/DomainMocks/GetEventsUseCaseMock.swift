//
//  GetEventsUseCaseMock.swift
//  AirHollandTests
//
//  Created by Atul Ghorpade on 14/10/21.
//

import Foundation
@testable import AirHolland

final class GetEventsUseCaseMock: GetEventsUseCase {
    var result: Result<[EventModel], UseCaseError>?
    
    func run(_ params: GetEventsParams) {
        guard let result = result else {
            fatalError("Result not provided to mock")
        }
        params.completion(result)
    }
}
