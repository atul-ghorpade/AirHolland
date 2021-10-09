enum UseCaseError: Error {
    case mapping(Swift.Error)
    case timeout(Swift.Error)
    case noConnection(Swift.Error)
    case airHollandApi(AirHollandApiError)
    case generic(Swift.Error)
}

enum AirHollandApiError: Error {
    case error400(Swift.Error)
    case error500(Swift.Error)
}
