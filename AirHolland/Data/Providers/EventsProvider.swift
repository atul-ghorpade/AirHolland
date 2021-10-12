import Foundation

class DefaultEventsProvider: EventsProviderProtocol {
    private let provider: Provider<EventsService>
    // TODO: Inject repository from outside - configurator
    private let repository = DefaultEventsRepositoy()

    convenience init() {
        self.init(provider: Provider<EventsService>())
    }

    init(provider: Provider<EventsService>) {
        self.provider = provider
    }

    func getEvents(shouldRefreshExplicitly: Bool, completion: @escaping EventsListCompletion) {
        guard !shouldRefreshExplicitly else {
            // fetch from service - the network API
            getEventsFromService(completion: completion)
            return
        }
        // Fetch from repository - the local storage
        repository.fetchEvents { result in
            switch result {
            case let .success(events):
            do {
                let eventsListModels = try events.map {
                    try $0.toDomain()
                }
                print("number of events from Data storage - \(eventsListModels.count)")
                return completion(.success(eventsListModels))
            } catch {
                print("mapping error - " + error.localizedDescription)
            }
            case let .failure(error):
                print("fetching error - " + error.localizedDescription)
            }
            // If error, fetch from service - the network API
            self.getEventsFromService(completion: completion)
        }
    }
    
    private func getEventsFromService(completion: @escaping EventsListCompletion) {
        provider.request(.eventsList) { result in
            switch result {
            case let .success(response):
                do {
                    let eventsListEntities = try response.map([EventEntity].self)
                    let eventsListModels = try eventsListEntities.map {
                        try $0.toDomain()
                    }
                    print("number of events from API - \(eventsListModels.count)")
                    self.repository.saveEvents(events: eventsListEntities)
                    completion(.success(eventsListModels))
                } catch {
                    completion(.failure(.mapping(error)))
                }
            case let .failure(error):
                completion(.failure(.generic(error)))
            }
        }
    }
}
