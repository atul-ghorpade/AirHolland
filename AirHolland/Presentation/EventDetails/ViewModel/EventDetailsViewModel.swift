//
//  EventDetailsViewModel.swift
//  AirHolland
//
//  Created by Atul Ghorpade on 12/10/21.
//

import Foundation

struct EventDetailsViewModelActions {}

protocol EventDetailsViewModelInput {}

protocol EventDetailsViewModelOutput {
    var screenTitle: String { get }
    
    var flightName: Observable<String> { get }
    var dateDisplayString: Observable<String> { get }
    var aircraftType: Observable<String> { get }
    var tail: Observable<String> { get }
    var departure: Observable<String> { get }
    var destination: Observable<String> { get }
    var departTime: Observable<String> { get }
    var arriveTime: Observable<String> { get }
    var duty: Observable<String> { get }
    var captain: Observable<String> { get }
    var firstOfficer: Observable<String> { get }
    var flightAttendant: Observable<String> { get }
}

protocol EventDetailsViewModel: EventDetailsViewModelInput, EventDetailsViewModelOutput {}

final class DefaultEventDetailsViewModel: EventDetailsViewModel {
    
    var screenTitle: String = "Event Details"
    
    // These are actually not required to be obsevable, but for MVVM demonstration purpose, kept these as observable
    var flightName: Observable<String> = Observable("N/A")
    var dateDisplayString: Observable<String> = Observable("N/A")
    var aircraftType: Observable<String> = Observable("N/A")
    var tail: Observable<String> = Observable("N/A")
    var departure: Observable<String> = Observable("N/A")
    var destination: Observable<String> = Observable("N/A")
    var departTime: Observable<String> = Observable("N/A")
    var arriveTime: Observable<String> = Observable("N/A")
    var duty: Observable<String> = Observable("N/A")
    var captain: Observable<String> = Observable("N/A")
    var firstOfficer: Observable<String> = Observable("N/A")
    var flightAttendant: Observable<String> = Observable("N/A")

    init(event: EventModel) {
        self.flightName.value = event.flightName ?? "N/A"
        self.dateDisplayString.value = event.date.toString(format: .custom("EEEE, dd MMMM, yyyy"))
        self.aircraftType.value = event.aircraftType ?? "N/A"
        self.tail.value = event.tail ?? "N/A"
        self.departure.value = event.departure ?? "N/A"
        self.destination.value = event.destination ?? "N/A"
        self.departTime.value = event.departTime ?? "N/A"
        self.arriveTime.value = event.arriveTime ?? "N/A"
        self.duty.value = event.dutyCode.getDisplayString()
        self.captain.value = event.captain ?? "N/A"
        self.firstOfficer.value = event.firstOfficer ?? "N/A"
        self.flightAttendant.value = event.flightAttendant ?? "N/A"
    }
}

extension DutyCode {
    func getDisplayString() -> String {
        switch self {
        case .flight:
            return "Flight"
        case .off:
            return "Off"
        case .layover:
            return "Layover"
        case .positioning:
            return "Positioning"
        case .standby:
            return "Standby"
        }
    }
}
