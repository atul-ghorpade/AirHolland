//
//  GetEventsUseCaseTests.swift
//  AirHollandTests
//
//  Created by Atul Ghorpade on 14/10/21.
//

import XCTest
@testable import AirHolland

class GetEventsUseCaseTests: XCTestCase {
    var useCase: GetEventsUseCase!
    let providerMock = EventsProviderMock()
    
    override func setUp() {
        super.setUp()
        useCase = DefaultGetEventsUseCase(provider: providerMock)
    }
    
    func testGetEventsSuccess() {
        let expectation = expectation(description: "Get Events success")
        providerMock.result = .success([getSampleEventModel()])
        useCase.run(GetEventsParams() { result in
            if case let .success(response) = result {
                XCTAssertEqual(response.count, 1)
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testGetEventsFailure() {
        let expectation = expectation(description: "Get Events failure")
        let underlyingError = NSError(domain: NSURLErrorDomain, code: 0, userInfo: nil)
        providerMock.result = .failure(.generic(underlyingError))
        useCase.run(GetEventsParams() { result in
            if case .failure = result {
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 1, handler: nil)
    }
}

extension GetEventsUseCaseTests {
    private func getSampleEventModel() -> EventModel {
        let date = Date(fromString: "06/05/2020",
                        format: .custom("dd/MM/yyyy")) ?? Date()
        return EventModel(flightName: "MX78",
                          date: date,
                          aircraftType: "748-800E",
                          tail: "9878",
                          departure: "AMS",
                          destination: "ALC",
                          departTime: "11:35",
                          arriveTime: "14:15",
                          dutyId: "FLT",
                          dutyCode: .flight,
                          captain: "Richard Versluis",
                          firstOfficer: "Jeroen Derwort",
                          flightAttendant: "Lucy Stone")
        
    }
}
