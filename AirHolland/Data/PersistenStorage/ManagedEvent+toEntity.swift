//
//  ManagedEvent+toEntity.swift
//  AirHolland
//
//  Created by Atul Ghorpade on 12/10/21.
//

import Foundation

extension ManagedEvent {
    func toEntity() -> EventEntity {
        return EventEntity(flightName: flightName ?? "",
                           dateString: dateString ?? "",
                           aircraftType: aircraftType ?? "",
                           tail: tail ?? "",
                           departure: departure ?? "",
                           destination: destination ?? "",
                           departTime: departTime ?? "",
                           arriveTime: arriveTime ?? "",
                           dutyId: dutyId ?? "",
                           dutyCode: dutyCode ?? "",
                           captain: captain ?? "",
                           firstOfficer: firstOfficer ?? "",
                           flightAttendant: flightAttendant ?? "")
    }
    
    func setValues(from eventEntity: EventEntity) {
        dutyCode = eventEntity.dutyCode
        departure = eventEntity.departure
        arriveTime = eventEntity.arriveTime
        flightName = eventEntity.flightName
        departTime = eventEntity.departTime
        destination = eventEntity.destination
        dutyId = eventEntity.dutyId
        flightAttendant = eventEntity.flightAttendant
        firstOfficer = eventEntity.firstOfficer
        captain = eventEntity.captain
        tail = eventEntity.tail
        aircraftType = eventEntity.aircraftType
        dateString = eventEntity.dateString
    }
}
