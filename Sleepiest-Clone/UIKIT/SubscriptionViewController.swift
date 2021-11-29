//
//  SubscriptionViewController.swift
//  Sleepiest-Clone
//
//  Created by Kudzaishe Mhou on 23/11/2021.
//

import Foundation
import UIKit
import Combine

final class SubscriptionViewController: UIViewController {
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return button
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.montserratSemiBold, size: 30)?.withWeight(.medium)
        label.textColor = .white
        label.text = "Join 29,087 others who joined this week"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurredEffectView.layer.masksToBounds = true
        blurredEffectView.clipsToBounds = true
        return blurredEffectView
    }()
    
    private lazy var freeTrialView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.backgroundColor = .clear
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "circular-check-mark")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalToConstant: 20),
                imageView.widthAnchor.constraint(equalToConstant: 20)
            ])
            return imageView
        }()
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: CustomFont.montserratSemiBold, size: 16)?.withWeight(.medium)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "7 Day Free Trial"
            return label
        }()
        
        view.embed(backgroundView)
        
        view.addSubview(iconImageView)
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            iconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        view.layer.cornerRadius = 15
       
        view.contentMode = .center
        return view
    }()
    
    private lazy var scrollableBulletPointsView: BulletPointsView = {
        let view = BulletPointsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.configureView(with: [
                                "100+ Bedtime Stories",
                                  "70+ Soundscapes",
                                  "20+ Sleep Meditations",
                                  "Create your own sleep sounds",
                                  "New content every week",
                                  "Award winning Narrators",
                                  "Apple App of the Day"
        ])
        
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.montserratSemiBold, size: 12)?.withWeight(.medium)
        
        let mutableAttributedString = NSMutableAttributedString()
        
        let attributedStringA = NSAttributedString(string:"Try 7 days free, then £28.99/year. Cancel anytime.", attributes:[NSAttributedString.Key.foregroundColor: Colors.palePurple,
                                                       NSAttributedString.Key.font: UIFont(name: CustomFont.montserratSemiBold, size: 18)?.withWeight(.medium) as Any])
        
        let attributedStringB = NSAttributedString(string:" Switch to monthly", attributes:[NSAttributedString.Key.foregroundColor: Colors.darkBlue,
                                                       NSAttributedString.Key.font: UIFont(name: CustomFont.montserratSemiBold, size: 18)?.withWeight(.medium) as Any])

        mutableAttributedString.append(attributedStringA)
        mutableAttributedString.append(attributedStringB)
        
        label.attributedText = mutableAttributedString
        
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subscribeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Try Free & Subscribe", for: .normal)
        button.titleLabel?.font = UIFont(name: CustomFont.montserratSemiBold, size: 16)?.withWeight(.medium)
        button.tintColor = .white
        button.clipsToBounds = true
        button.backgroundColor = Colors.skyBlue
        button.addTarget(self, action: #selector(subscribe), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.layer.cornerRadius = 30
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var blurredEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurredEffectView
    }()
    
    private let loadingViewController: LoadingViewController = {
        let view = LoadingViewController()
        return view
    }()
    
    private var subscriptions: Set<AnyCancellable> = .init()
    private let inAppPurchaseManager = InAppPurchaseManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
       
        setupView()
        backgroundView.layer.cornerRadius = 15
        
        self.inAppPurchaseManager.$viewState.sink { [weak self] state in
            
            guard let `self` = self else {
                return
            }
            
            switch state {
            case .initial:
                self.hideLoadingView()
                self.showViewComponents()
            case .loading:
                self.hideViewComponents()
                self.showLoadingView()
            case .purchased:
                self.loadingViewController.updateMeggase()
                self.hideLoadingView()
                self.dismiss(animated: true, completion: nil)
                
            case .restored:
                self.hideLoadingView()
            case .failedPurchase:
                self.hideLoadingView()
                self.showViewComponents()
            }
                                   
        }.store(in: &subscriptions)
        
        animateShow([button, logoImageView, titleLabel, freeTrialView, scrollableBulletPointsView, messageLabel, subscribeButton])
    }
    
    func setupView() {
        
        view.embed(blurredEffectView)
        
        contentView.addSubview(button)
        contentView.addSubview(logoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(freeTrialView)
        contentView.addSubview(scrollableBulletPointsView)
        contentView.addSubview(messageLabel)
        contentView.addSubview(subscribeButton)
        
        // add the content view
        scrollView.embed(contentView)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        // add the scroll view
        view.embed(scrollView)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),

            logoImageView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor),

            freeTrialView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            freeTrialView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            scrollableBulletPointsView.topAnchor.constraint(equalTo: freeTrialView.bottomAnchor, constant: 12),
            scrollableBulletPointsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            scrollableBulletPointsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            scrollableBulletPointsView.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -20),
            messageLabel.bottomAnchor.constraint(equalTo: subscribeButton.topAnchor, constant: -20),
            messageLabel.leadingAnchor.constraint(equalTo: subscribeButton.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: subscribeButton.trailingAnchor),

            subscribeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            subscribeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            subscribeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func subscribe() {
       showLoadingView()
    }
    
    func showViewComponents() {

        UIView.animate(withDuration: 0.3, animations: {
            self.button.alpha = 1
            self.logoImageView.alpha = 1
            self.titleLabel.alpha = 1
            self.freeTrialView.alpha = 1
            self.scrollableBulletPointsView.alpha = 1
            self.messageLabel.alpha = 1
            self.subscribeButton.alpha = 1
        }) { (finished) in
            self.button.isHidden = !finished
            self.logoImageView.isHidden = !finished
            self.titleLabel.isHidden = !finished
            self.freeTrialView.isHidden = !finished
            self.scrollableBulletPointsView.isHidden = !finished
            self.messageLabel.isHidden = !finished
            self.subscribeButton.isHidden = !finished
        }
        
//        animateShow([button, logoImageView, titleLabel, freeTrialView, scrollableBulletPointsView, messageLabel, subscribeButton])
    }
    
    func hideViewComponents() {
        button.isHidden = true
        logoImageView.isHidden = true
        titleLabel.isHidden = true
        freeTrialView.isHidden = true
        scrollableBulletPointsView.isHidden = true
        messageLabel.isHidden = true
        subscribeButton.isHidden = true
        
        UIView.animate(withDuration: 0.3, animations: {
            self.button.alpha = 0
            self.logoImageView.alpha = 0
            self.titleLabel.alpha = 0
            self.freeTrialView.alpha = 0
            self.scrollableBulletPointsView.alpha = 0
            self.messageLabel.alpha = 0
            self.subscribeButton.alpha = 0
        }) { (finished) in
            self.button.isHidden = finished
            self.logoImageView.isHidden = finished
            self.titleLabel.isHidden = finished
            self.freeTrialView.isHidden = finished
            self.scrollableBulletPointsView.isHidden = finished
            self.messageLabel.isHidden = finished
            self.subscribeButton.isHidden = finished
        }
    }
    
    func showLoadingView() {
       
        self.addChild(loadingViewController)
        self.loadingViewController.view.frame = view.bounds
        self.view.addSubview(loadingViewController.view)
        self.view.bringSubviewToFront(loadingViewController.view)
        self.loadingViewController.didMove(toParent: self)
    }
    
    func hideLoadingView() {
        self.loadingViewController.willMove(toParent: nil)
        self.loadingViewController.view.removeFromSuperview()
        self.loadingViewController.removeFromParent()
    }
    
    private func animateShow(_ views: [UIView]) {
        views.enumerated().forEach { (index, view) in
            view.alpha = 0
            view.transform = CGAffineTransform(translationX: 0.5, y: 0.1)
    
            UIView.animate(
                withDuration: 1.8,
                delay: 0.8 * Double(index),
                options: [.curveEaseInOut],
                animations: {
                    let transformTrans = CGAffineTransform(translationX: 1.0, y: 0.1)
                    view.transform = transformTrans
                    view.alpha = 1
            })
        }
    }
}

