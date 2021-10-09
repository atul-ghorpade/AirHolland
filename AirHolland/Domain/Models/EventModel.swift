//

import Foundation

struct EventModel: Equatable {
    let flightName: String?
    let date: Date
    let aircraftType: String?
    let tail: String?
    let departure: String?
    let destination: String?
    let departTime: Date?
    let arriveTime: Date?
    let dutyId: String?
    let dutyCode: DutyCode?
    let captain: String?
    let firstOfficer: String?
    let flightAttendant: String?
}

enum DutyCode: String, Decodable {
    case standby = "Standby"
    case flight = "FLIGHT"
    case off = "OFF"
    case positioning = "POSITIONING"
}
