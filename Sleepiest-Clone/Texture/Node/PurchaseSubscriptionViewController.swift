//
//  PurchaseSubscriptionViewController.swift
//  Sleepiest-Clone
//
//  Created by Kudzaiishe Mhou on 2021/11/25.
//

import AsyncDisplayKit
import Firebase
import Combine

final class PurchaseSubscriptionViewController: ASDKViewController<ASDisplayNode> {
    
    private let blurEffectNode = ASDisplayNode(viewBlock: { () -> UIView in
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
        
        let vibrancy = UIVibrancyEffect(blurEffect: UIBlurEffect(style: .systemChromeMaterialDark))
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancy)
        vibrancyEffectView.isHidden = false
        
        blurEffectView.contentView.addSubview(vibrancyEffectView)
        return blurEffectView
    })
    
    private let backGroundImageNode = ASImageNode().then {
        $0.image = UIImage(named: "background")
        $0.contentMode = .scaleAspectFill
        $0.displaysAsynchronously = false
        $0.isUserInteractionEnabled = true
    }
    
    private let purchaseSubscriptionNode = PurchaseSubscriptionNode().then {
        $0.isUserInteractionEnabled = true
    }
    
    lazy var titleNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        node.attributedText = NSAttributedString(string: "trySevenDays.free.text".localized, attributes: [NSAttributedString.Key.foregroundColor: Colors.palePurple,
                                                                                                          NSAttributedString.Key.font: UIFont(name: CustomFont.montserratSemiBold, size: 18)?.withWeight(.medium) as Any])
        return node
    }()
    
    private var cancellable: Set<AnyCancellable> = .init()
    private let impact = UIImpactFeedbackGenerator(style: .light)
    
    // MARK: - Initalization
    override init() {
        super.init(node: .init())
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
        
        purchaseSubscriptionNode.closeButtonNode.addTarget(self, action: #selector(close), forControlEvents: .touchUpInside)
        
        purchaseSubscriptionNode.bottomNode.subscribeButtonNode.addTarget(self, action: #selector(subscribe), forControlEvents: .touchUpInside)
        
        self.view.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0) { status, error in
            if let error = error {
                print("Error fetching config: \(error)")
            }
            print("Config fetch completed with status: \(status.debugDescription)")
            self.setAppearance()
        }
    }
    
    func setAppearance() {
        RemoteConfig.remoteConfig().activate { activated, error in
            let configValue = RemoteConfig.remoteConfig()["subscribe_button_color"]
            print("Config value: \(configValue.stringValue ?? "null")")
            
            DispatchQueue.main.async {
                if configValue.stringValue == "skyBlue" {
                    self.purchaseSubscriptionNode.bottomNode.subscribeButtonNode.backgroundColor = Colors.skyBlue
                } else if configValue.stringValue == "palePurple"  {
                    self.purchaseSubscriptionNode.bottomNode.subscribeButtonNode.backgroundColor = Colors.palePurple
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        purchaseSubscriptionNode.transitionLayout(withAnimation: true, shouldMeasureAsync: false)
    }
    
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        
        let backgroundLayoutSpec = blurEffectNode.background(with: backGroundImageNode)
        
        let insetSpec = ASInsetLayoutSpec(
            insets: .init(top: 16, left: 8, bottom: 0, right: 8),
            child: purchaseSubscriptionNode
        )
        
        return ASBackgroundLayoutSpec(child: insetSpec, background: backgroundLayoutSpec)
    }
    
    func binding() {
        InAppPurchaseManager.sharedInstance.$viewState.sink { [weak self] state in
            guard let `self` = self else {
                return
            }
            
            switch state {
            case .purchased, .restored:
                self.close()
            default:
                break
            }
        }.store(in: &cancellable)
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func subscribe() {
        impact.impactOccurred()
        purchaseSubscriptionNode.showComponents = false
        purchaseSubscriptionNode.viewState = .loading
        purchaseSubscriptionNode.transitionLayout(withAnimation: true, shouldMeasureAsync: false)
        purchaseSubscriptionNode.loadingNode.transitionLayout(withAnimation: true, shouldMeasureAsync: false)
        purchaseSubscriptionNode.scrollNode.transitionLayout(withAnimation: true, shouldMeasureAsync: false)
        showSubscriptionForSelectedPeriod()
    }
    
    func showSubscriptionForSelectedPeriod() {
        switch purchaseSubscriptionNode.bottomNode.subscriptionType {
        case .monthly:
            InAppPurchaseManager.sharedInstance.buyUnlockTestMonthlyInAppPurchase()
        case .yearly:
            InAppPurchaseManager.sharedInstance.buyUnlockYearlyTestInAppPurchase()
        }
    }
}
