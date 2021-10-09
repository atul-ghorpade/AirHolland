import Foundation

final class AppDIContainer {
    func buildEventsListDIContainer() -> EventsDIContainer {
        return EventsDIContainer()
    }
}
