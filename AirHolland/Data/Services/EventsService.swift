import Foundation

enum EventsService {
    case eventsList
}

extension EventsService: TargetType {
    var baseURL: URL {
        return URL(string: "https://rosterbuster.aero/wp-content/" + servicePath)!
    }

    var servicePath: String {
        "uploads"
    }

    var path: String {
        switch self {
        case .eventsList:
            return "/dummy-response.json"
        }
    }

    var method: Method {
        switch self {
        case .eventsList:
            return .get
        }
    }

    var task: Task {
        return .requestPlain
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }

    var sampleData: Data {
        guard let url = Bundle.main.url(forResource: mockResource, withExtension: mockResourceExtension),
              let data = try? Data(contentsOf: url) else {
            return Data()
        }
        return data
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

    var mockResource: String {
        switch self {
        case .eventsList:
            return "EventsList"
        }
    }

    var mockResourceExtension: String {
        return "json"
    }
}
