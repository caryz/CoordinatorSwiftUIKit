//
//  Coordinator.swift
//  CoordinatorSwiftUIKit
//
//  Created by Cary Zhou on 2/25/21.
//

import UIKit
import SwiftUI
import Combine

protocol Coordinator {
//    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

/// 1. Start with a Coordinator of your choice, see `Coordinator.swift` for impl details.
/// For illustration purposes, this coordinator will only manage:
/// - Navigation push/pop
/// - Observe some values
class MyCoordinator: Coordinator, ObservableObject {

    var navigationController: UINavigationController = UINavigationController()

    @Published var myCount = 0

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        /// Start with UIKit View
        let uiKitView = MyViewController.create(text: "My UIKit View",
                                                bgColor: .gray,
                                                coordinator: self)
        navigationController.pushViewController(uiKitView, animated: true)
    }

    enum Screen {
        case uikit, swiftui
    }

    /// 2. We can use the coordinator to show both UIKit and SwiftUI Views via UIKit's NavigationController
    func navigate(to destination: Screen) {
        switch destination {
        case .uikit:
            let uiKitView = MyViewController.create(text: "My UIKit View", bgColor: .gray, coordinator: self)
            navigationController.pushViewController(uiKitView, animated: true)
        case .swiftui:
            let swiftUIView = SwiftUIView(text: "SwiftUI View", color: .green).environmentObject(self)
            navigationController.pushViewController(UIHostingController(rootView: swiftUIView), animated: true)
        }
    }
}
