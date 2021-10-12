//
//  EventsRepository.swift
//  AirHolland
//
//  Created by Atul Ghorpade on 12/10/21.
//

import CoreData
import Foundation

protocol EventsRepository {
    func fetchEvents(completion: @escaping (Result<[EventEntity], Error>) -> Void)
    func saveEvents(events: [EventEntity])
}

final class DefaultEventsRepositoy: EventsRepository {
    func fetchEvents(completion: @escaping (Result<[EventEntity], Error>) -> Void) {
        do {
            let fetchRequest: NSFetchRequest<ManagedEvent>
            fetchRequest = ManagedEvent.fetchRequest()
            let context = CoreDataStorage.shared.persistentContainer.viewContext
            let managedEvents = try context.fetch(fetchRequest)
            let events = managedEvents.map {
                $0.toEntity()
            }
            completion(.success(events))
        } catch {
            completion(.failure(error))
        }
    }
    
    func saveEvents(events: [EventEntity]) {
        // TODO: add it on background queue - performBackgroundFetch or privateConcurrencyQueue
        let context = CoreDataStorage.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedEvent")
        // Delete existing
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try CoreDataStorage.shared.persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: context)
        } catch {
            print("deleting error - " + error.localizedDescription)
        }
        
        // Save current
        for event in events {
            let managedEvent = NSEntityDescription.insertNewObject(forEntityName: "ManagedEvent", into: context) as? ManagedEvent
            managedEvent?.setValues(from: event)
        }
        do {
            try context.save()
        } catch {
            print("saving error - " + error.localizedDescription)
        }
    }
}
