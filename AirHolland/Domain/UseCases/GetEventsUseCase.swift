struct GetEventsParams {
    typealias Completion = (Result<[EventModel], UseCaseError>) -> Void

    let completion: Completion

    init(completion: @escaping Completion) {
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
        provider.getEvents { result in
            params.completion(result)
        }
    }
}
