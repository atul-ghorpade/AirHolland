import DateHelper
import Foundation

struct EventEntity: Decodable {
    let flightName: String
    let dateString: String
    let aircraftType: String
    let tail: String
    let departure: String
    let destination: String
    let departTime: String
    let arriveTime: String
    let dutyId: String
    let dutyCode: String
    let captain: String
    let firstOfficer: String
    let flightAttendant: String
        
    enum CodingKeys: String, CodingKey {
        case flightName = "Flightnr"
        case dateString = "Date"
        case aircraftType = "Aircraft Type"
        case tail = "Tail"
        case departure = "Departure"
        case destination = "Destination"
        case departTime = "Time_Depart"
        case arriveTime = "Time_Arrive"
        case dutyId = "DutyID"
        case dutyCode = "DutyCode"
        case captain = "Captain"
        case firstOfficer = "First Officer"
        case flightAttendant = "Flight Attendant"
    }
    
    func toDomain() throws -> EventModel {
        let flightName = flightName.isEmpty ? nil : flightName
        guard let date = Date(fromString: dateString, format: .custom("dd/MM/yyyy")) else {
            let error = EncodingError.Context(codingPath: [EventEntity.CodingKeys.dateString],
                                              debugDescription: "invalid date")
            throw EncodingError.invalidValue(self, error)
        }
        let aircraftType = aircraftType.isEmpty ? nil : aircraftType
        let tail = tail.isEmpty ? nil : tail
        let departure = departure.isEmpty ? nil : departure
        let destination = destination.isEmpty ? nil : destination
        let departTime = departTime.isEmpty ? nil : departTime
        let arriveTime = arriveTime.isEmpty ? nil : arriveTime
        let dutyId = dutyId.isEmpty ? nil : dutyId
        let dutyCode = DutyCode(rawValue: dutyCode) ?? .off
        let captain = captain.isEmpty ? nil : captain
        let firstOfficer = firstOfficer.isEmpty ? nil : firstOfficer
        let flightAttendant = flightAttendant.isEmpty ? nil : flightAttendant
        
        return EventModel(flightName: flightName,
                          date: date,
                          aircraftType: aircraftType,
                          tail: tail,
                          departure: departure,
                          destination: destination,
                          departTime: departTime,
                          arriveTime: arriveTime,
                          dutyId: dutyId,
                          dutyCode: dutyCode,
                          captain: captain,
                          firstOfficer: firstOfficer,
                          flightAttendant: flightAttendant)
    }
}
