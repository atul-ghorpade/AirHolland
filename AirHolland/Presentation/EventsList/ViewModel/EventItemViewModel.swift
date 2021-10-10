//

import Foundation
import UIKit

struct EventItemViewModel: Equatable {
    let imageName: String?
    let title: String
    let description: String?
    let timeDescription: String?
    let time: String
}

extension EventItemViewModel {
    init(_ event: EventModel) {
        self.imageName = EventItemViewModel.getImageName(dutyCode: event.dutyCode)
        self.title = EventItemViewModel.getTitle(dutyCode: event.dutyCode,
                                                 departure: event.departure,
                                                 destination: event.destination)
        self.description = EventItemViewModel.getTitleDescription(dutyCode: event.dutyCode,
                                                                  departure: event.departure)
        self.timeDescription = EventItemViewModel.getTimeDescription(dutyCode: event.dutyCode)
        self.time = EventItemViewModel.getTime(dutyCode: event.dutyCode,
                                               departTime: event.departTime,
                                               arriveTime: event.arriveTime)
    }
    
    static func getImageName(dutyCode: DutyCode) -> String {
        switch dutyCode {
        case .standby:
            return "\u{f0ea}"
        case .flight:
            return "\u{f072}"
        case .layover:
            return "\u{f0f2}"
        case .positioning:
            return "\u{f5fd}"
        case .off:
            return "\u{f011}"
        }
    }
    
    static func getTitle(dutyCode: DutyCode, departure: String?, destination: String?) -> String {
        switch dutyCode {
        case .standby:
            return "Standby"
        case .layover:
            return "Layover"
        case .flight, .positioning, .off:
            return (departure ?? "") + " - " + (destination ?? "")
        }
    }
    
    static func getTitleDescription(dutyCode: DutyCode, departure: String?) -> String {
        switch dutyCode {
        case .standby:
            return "SBY (\(departure ?? ""))"
        case .off:
            return "OFF"
        case .layover:
            return departure ?? ""
        case .flight, .positioning:
            return ""
        }
    }
    
    static func getTimeDescription(dutyCode: DutyCode) -> String {
        guard dutyCode == .standby else {
            return ""
        }
        return "Match Crew"
    }
    
    static func getTime(dutyCode: DutyCode, departTime: String?, arriveTime: String?) -> String {
        guard dutyCode != .layover else {
            return arriveTime ?? "" + " hours"
        }
        return (departTime ?? "") + " - " + (arriveTime ?? "")
    }
}
