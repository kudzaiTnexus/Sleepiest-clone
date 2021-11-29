//
//  ViewController.swift
//  Sleepiest-Clone
//
//  Created by Kudzaishe Mhou on 10/11/2021.
//

import UIKit

class ViewController: UIViewController {
    
    let textureButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("(Texture) Open subscription screen", for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(textureSubscription), for: .touchUpInside)
        return button
    }()
    
    let uikitbutton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("(UIKIT) Open subscription screen", for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(uikitSubscription), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        
        view.addSubview(textureButton)
        view.addSubview(uikitbutton)
        
        NSLayoutConstraint.activate([
            textureButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            uikitbutton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60),
            uikitbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    @objc func textureSubscription() {
        let textureSubscriptionViewController = PurchaseSubscriptionViewController()
        textureSubscriptionViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(textureSubscriptionViewController, animated: true)
    }
    
    @objc func uikitSubscription() {
        let subscriptionViewController = SubscriptionViewController()
        subscriptionViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(subscriptionViewController, animated: true)
    }
}

