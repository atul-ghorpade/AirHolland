struct GetEventsParams {
    typealias Completion = (Result<[EventModel], UseCaseError>) -> Void
    
    let shouldRefreshExplicitly: Bool
    let completion: Completion

    init(shouldRefreshExplicitly: Bool = false, completion: @escaping Completion) {
        self.shouldRefreshExplicitly = shouldRefreshExplicitly
        self.completion = completion
    }
}

protocol GetEventsUseCase {
    func run(_ params: GetEventsParams)
}

final class DefaultGetEventsUseCase: GetEventsUseCase {
    private let provider: EventsProviderProtocol!

    init(provider: EventsProviderProtocol) {
        self.provider = provider
    }

    func run(_ params: GetEventsParams) {
        provider.getEvents(shouldRefreshExplicitly: params.shouldRefreshExplicitly) { result in
            params.completion(result)
        }
    }
}
