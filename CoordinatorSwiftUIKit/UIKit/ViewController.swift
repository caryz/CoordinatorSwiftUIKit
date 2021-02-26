//
//  ViewController.swift
//  CoordinatorSwiftUIKit
//
//  Created by Cary Zhou on 2/25/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var showModalButton: UIButton!

    /// Hold a reference to the coordinator
    var coordinator: MyCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator = MyCoordinator(UINavigationController())
        coordinator?.start()
    }

    @IBAction func showModalButtonTapped(_ sender: UIButton) {
        guard let navController = coordinator?.navigationController else { return }
        present(navController, animated: true)
    }
}

