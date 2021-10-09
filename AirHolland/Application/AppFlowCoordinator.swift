import Foundation
import UIKit

final class AppFlowCoordinator {
    var navigationController:UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController:UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let eventsListDIContainer = appDIContainer.buildEventsListDIContainer()
        let flow = eventsListDIContainer.buildEventsListFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
