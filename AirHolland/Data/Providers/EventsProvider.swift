import Foundation

class EventsProvider: EventsProviderProtocol {
    private let provider: Provider<EventsService>

    convenience init() {
        self.init(provider: Provider<EventsService>())
    }

    init(provider: Provider<EventsService>) {
        self.provider = provider
    }

    func getEvents(completion: @escaping EventsListCompletion) {
        provider.request(.eventsList) { result in
            switch result {
            case let .success(response):
                do {
                    let eventsListEntities = try response.map([EventEntity].self)
                    let eventsListModels = try eventsListEntities.map {
                        try $0.toDomain()
                    }
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
