//
//  LoadingViewController.swift
//  Sleepiest-Clone
//
//  Created by Kudzaishe Mhou on 24/11/2021.
//

import Foundation
import UIKit


class LoadingViewController: UIViewController {

    private lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.center = self.view.center
        activityView.color = .white
        activityView.startAnimating()
        
        return activityView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.montserratSemiBold, size: 18)?.withWeight(.medium)
        label.textColor = .white
        label.text = "Great sleep is just one step away..."
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 240).isActive = true
        return label
    }()


    deinit {
        hideActivityIndicator()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        view.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        InAppPurchaseManager.sharedInstance.buyUnlockTestMonthlyInAppPurchase()
    }

    func setupView() {

        view.addSubview(activityView)
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60),
        ])
    }
    
    func updateMeggase() {
        titleLabel.text = "Get ready to start sleeping better..."
    }

    func hideActivityIndicator() {
        activityView.stopAnimating()
    }
}
