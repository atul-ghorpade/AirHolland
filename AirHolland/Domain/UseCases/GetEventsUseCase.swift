struct GetEventsParams {
    typealias Completion = (Result<[EventModel], UseCaseError>) -> Void

    let completion: Completion

    init(completion: @escaping Completion) {
        self.completion = completion
    }
}

protocol GetEventsUseCaseProtocol {
    func run(_ params: GetEventsParams)
}

final class GetEventsUseCase: GetEventsUseCaseProtocol {
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
