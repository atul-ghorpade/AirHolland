//
//  EventsListViewModelTests.swift
//  AirHollandTests
//
//  Created by Atul Ghorpade on 14/10/21.
//

import DateHelper
import XCTest
@testable import AirHolland

class EventsListViewModelTests: XCTestCase {
    
    var viewModel: DefaultEventsListViewModel!
    let useCaseMock = GetEventsUseCaseMock()

    override func setUp() {
        super.setUp()
        viewModel = DefaultEventsListViewModel(eventsListUseCase: useCaseMock)
    }
    
    func testEventsListLoadedWithEvents() throws {
        useCaseMock.result = .success([getSampleEventModel()])
        viewModel.viewLoaded()
        let eventSectionModel = try XCTUnwrap(viewModel.items.value.first)
        XCTAssertNotNil(eventSectionModel)
        XCTAssertEqual(eventSectionModel.rows.count, 1)
    }
    
    func testEventsListLoadedWithError() throws {
        let error = NSError(domain: NSURLErrorDomain, code: 0, userInfo: nil)
        let useCaseError = UseCaseError.generic(error)
        useCaseMock.result = .failure(useCaseError)
        viewModel.viewLoaded()
        XCTAssertEqual(viewModel.error.value, "Oops! Error while fetching events")
    }
    
    func testEventsListPulledToRefresh() throws {
        useCaseMock.result = .success([getSampleEventModel()])
        viewModel.viewLoaded()
        let eventSectionModel = try XCTUnwrap(viewModel.items.value.first)
        XCTAssertEqual(eventSectionModel.rows.count, 1)
        useCaseMock.result = .success([getSampleEventModel(),
                                       getSampleEventModel(),
                                       getSampleEventModel()])
        viewModel.listRefreshPulled()
        let eventSectionModelRefreshed = try XCTUnwrap(viewModel.items.value.first)
        XCTAssertEqual(eventSectionModelRefreshed.rows.count, 3)
    }
}

extension EventsListViewModelTests {
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
