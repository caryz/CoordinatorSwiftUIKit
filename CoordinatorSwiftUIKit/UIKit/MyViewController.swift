//
//  MyViewController.swift
//  CoordinatorSwiftUIKit
//
//  Created by Cary Zhou on 2/25/21.
//

import UIKit
import Combine

/// Reference: https://www.swiftbysundell.com/articles/published-properties-in-swift/
class MyViewController: UIViewController {

    class func create(text: String = "", bgColor: UIColor = .clear, coordinator: MyCoordinator?) -> MyViewController {
        let viewController = MyViewController()
        viewController.text = text
        viewController.bgColor = bgColor
        viewController.coordinator = coordinator
        return viewController
    }

    var text: String = ""
    var bgColor: UIColor = .clear
    var coordinator: MyCoordinator?

    private var cancellable: AnyCancellable?
    private var addButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "UIKit View"
        view.backgroundColor = bgColor

        let label = UILabel(frame: .zero)
        label.text = text

        let uiKitButton = UIButton(frame: .zero)
        uiKitButton.setTitle("UIKitView", for: .normal)
        uiKitButton.addTarget(self, action: #selector(uiKitButtonTapped), for: .touchUpInside)

        let swiftUiButton = UIButton(frame: .zero)
        swiftUiButton.setTitle("SwiftUIView", for: .normal)
        swiftUiButton.addTarget(self, action: #selector(swiftUiButtonTapped), for: .touchUpInside)

        guard let coordinator = coordinator else { return }
        let addButton = UIButton(frame: .zero)
        addButton.setTitle("Add Count: \(coordinator.myCount)", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        self.addButton = addButton

        let stackview = UIStackView(arrangedSubviews: [
            label,
            uiKitButton,
            swiftUiButton,
            addButton
        ])

        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackview)
        stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        setupPubSub()
    }


    private func setupPubSub() {
        cancellable = coordinator?.$myCount.sink(receiveValue: { (value: Int) in
            print("Value Changed UIKit: \(value)")
        })
    }

    @objc func uiKitButtonTapped() {
        coordinator?.navigate(to: .uikit)
    }

    @objc func swiftUiButtonTapped() {
        coordinator?.navigate(to: .swiftui)
    }

    @objc func addButtonTapped() {
        guard let coordinator = coordinator else { return }
        coordinator.myCount += 1
        addButton?.setTitle("Add Count: \(coordinator.myCount)", for: .normal)
    }
}
