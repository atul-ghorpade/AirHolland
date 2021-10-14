//
//  EventsItemViewModelTests.swift
//  AirHollandTests
//
//  Created by Atul Ghorpade on 14/10/21.
//

import XCTest
@testable import AirHolland

class EventsItemViewModelTests: XCTestCase {
    var viewModel: EventItemViewModel!

    override func setUp() {
        super.setUp()
    }
    
    func testImageName() {
        viewModel = EventItemViewModel(getSampleEventModel())
        XCTAssertEqual(viewModel.imageName, "\u{f072}")
    }
    
    func testTitle() {
        viewModel = EventItemViewModel(getSampleEventModel())
        XCTAssertEqual(viewModel.title, "AMS - ALC")
    }
    
    func testTimeDescription() {
        viewModel = EventItemViewModel(getSampleEventModel())
        XCTAssertTrue(viewModel.timeDescription?.isEmpty ?? false)
    }
    
    func testTime() {
        viewModel = EventItemViewModel(getSampleEventModel())
        XCTAssertEqual(viewModel.time, "11:35 - 14:15")
    }
}
    
extension EventsItemViewModelTests {
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

