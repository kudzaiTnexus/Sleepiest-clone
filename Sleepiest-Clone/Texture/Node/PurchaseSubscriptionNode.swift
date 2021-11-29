//
//  PurchaseSubscriptionNode.swift
//  Sleepiest-Clone
//
//  Created by Kudzaiishe Mhou on 2021/11/25.
//

import UIKit
import AsyncDisplayKit
import Then
import Combine

final class PurchaseSubscriptionNode: ASDisplayNode {
    
    enum State {
        case loading
        case none
        case cancel
    }
    
    private let  items: [String] = [
        "bulletPoint.bedTimeStories.text".localized,
        "bulletPoint.soundscapes.text".localized,
        "bulletPoint.sleepMeditations.text".localized,
        "bulletPoint.sleepSounds.text".localized,
        "bulletPoint.newContent.text".localized,
        "bulletPoint.narrators.text".localized,
        "bulletPoint.appOfTheDay.text".localized
    ]
    
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [NSAttributedString.Key.foregroundColor: Colors.palePurple,
                    NSAttributedString.Key.font: UIFont(name: CustomFont.montserratSemiBold, size: 18)?.withWeight(.medium) as Any]
        }
        
        static var subtitleAttribute: [NSAttributedString.Key: Any] {
            return [NSAttributedString.Key.foregroundColor: Colors.darkBlue,
                    NSAttributedString.Key.font: UIFont(name: CustomFont.montserratSemiBold, size: 18)?.withWeight(.medium) as Any]
        }
    }
    
    let scrollNode = ASScrollNode().then {
        $0.automaticallyManagesSubnodes = true
        $0.automaticallyManagesContentSize = true
        $0.view.showsVerticalScrollIndicator = false
        $0.view.showsHorizontalScrollIndicator = false
    }
    
    // MARK: UI
    let closeButtonNode = ASButtonNode().then {
        $0.setImage(UIImage(named: "close"), for: .normal)
        $0.style.preferredSize = CGSize(width: 30, height: 30)
        $0.imageNode.contentMode = .scaleAspectFit
        $0.contentMode = .scaleAspectFit
        $0.alpha = 0
    }
    
    private let imageNode = ASImageNode().then {
        $0.image = UIImage(named: "logo")
        $0.style.preferredSize = CGSize(width: 160, height: 40)
        $0.contentMode = .scaleAspectFit
        $0.accessibilityLabel = "logo.sleepiest.description.text".localized
        $0.alpha = 0
        $0.displaysAsynchronously = false
    }
    
    private lazy var bulletPointNode = BulletsPointNode(items).then {
        $0.backgroundColor = .clear
        $0.alpha = 0
    }
    
    let bottomNode = BottomNode().then {
        $0.backgroundColor = .clear
        $0.alpha = 0
    }
    
    let loadingNode = LoadingNode().then {
        $0.backgroundColor = .clear
    }
    
    private lazy var headerNode = HeaderNode(title: "joinOthers.title".localized,
                                             trialPeriod: "freeTrial.text".localized).then {
        $0.backgroundColor = .clear
        $0.alpha = 0
    }
    
    var viewState: State = .none {
        didSet {
            setNeedsLayout()
        }
    }
    
    var showComponents: Bool = true
    
    private var cancellable: Set<AnyCancellable> = .init()
    private let inAppPurchaseManager = InAppPurchaseManager.sharedInstance
    
    // MARK: Initializing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    override func didLoad() {
        super.didLoad()
        
        binding()
    }
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {

        scrollNode.layoutSpecBlock = { [unowned self] node, constrainedSize in
            let loadingIndicatorLayoutSpec = ASStackLayoutSpec(
                 direction: .vertical,
                 spacing: 0,
                 justifyContent: .center,
                 alignItems: .center,
                 children: [ loadingNode ]
             )
             
             return ASOverlayLayoutSpec(
                child: contentLayoutSpec(),
                overlay: loadingIndicatorLayoutSpec
             )
        }
        
        return ASInsetLayoutSpec(insets: .bottom(20), child: scrollNode)
    }
    
    func binding() {
        self.inAppPurchaseManager.$viewState.sink { [weak self] state in
            
            guard let `self` = self else {
                return
            }
            
            switch state {
            case .initial:
                self.viewState = .none
            case .loading:
                self.viewState = .loading
            case .purchased:
                self.loadingNode.updateMeggase()
            case .restored:
                self.loadingNode.updateMeggase()
            case .failedPurchase:
                self.viewState = .cancel
                self.configureView()
            }
                                   
        }.store(in: &cancellable)
        
        
        bottomNode.$subscriptionType.sink { [weak self] subscripton in
            guard let `self` = self else {
                return
            }
            switch subscripton {
            case .monthly:
                self.switchToMonthlySubscriptions()
            case .yearly:
                self.switchToYearlySubscriptions()
            }
        }.store(in: &cancellable)
    }
    
    private func closeButtonLayout() -> ASLayoutSpec {
        let stackLayout = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 0,
                                            justifyContent: .end,
                                            alignItems: .start,
                                            children: [closeButtonNode])
        
        return ASInsetLayoutSpec(insets: .zero, child: stackLayout)
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        
        configureView()
        
        var containerInsets: UIEdgeInsets = self.safeAreaInsets
        containerInsets.left = 20.0
        containerInsets.right = 20.0
        containerInsets.top = 30.0
        
        let stackLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 20,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                closeButtonLayout(),
                imageNode,
                headerNode,
                bulletPointNode,
                bottomNode
            ]
        )
        
        return ASInsetLayoutSpec(insets: containerInsets, child: stackLayout)
    }
    
    override func animateLayoutTransition(_ context: ASContextTransitioning) {
        if showComponents {
            animateShow([
                closeButtonNode,
                imageNode,
                headerNode,
                bulletPointNode,
                bottomNode
            ])
        } else {
            animateHide([
                bottomNode,
                bulletPointNode,
                headerNode,
                imageNode,
                closeButtonNode
                
            ])
        }
    }
    
    private func configureView() {
        switch viewState {
        case .loading:
            loadingNode.isLoading = true
        case .cancel:
            animateHide([loadingNode]) { fin in
                self.loadingNode.isLoading = !fin
            }
            
            animateShow([
                closeButtonNode,
                imageNode,
                headerNode,
                bulletPointNode,
                bottomNode
            ])

        default:
            loadingNode.isLoading = false
        }
    }
    
    private func animateShow(_ nodes: [ASDisplayNode]) {
        nodes.enumerated().forEach { (index, node) in
            node.transform = CATransform3DMakeTranslation(0, 100, 0)
    
            UIView.animate(
                withDuration: 1.4,
                delay: 0.7 * Double(index),
                options: [.curveEaseInOut],
                animations: {
                    let transformTrans = CATransform3DMakeTranslation(1, 1, 1)
                    node.transform = transformTrans
                    node.alpha = 1
            })
        }
    }
    
    private func animateHide(_ nodes: [ASDisplayNode],
                             completion: ((Bool)->())? = nil) {
        nodes.enumerated().forEach { (index, node) in
            node.transform = CATransform3DMakeTranslation(0, 1, 0)
            
            UIView.animate(
                withDuration: 1.0,
                delay: 0.4 * Double(index),
                options: [.curveEaseInOut],
                animations: {
                    let transformTrans = CATransform3DMakeTranslation(1, 50, 1)
                    node.transform = transformTrans
                    node.alpha = 0
                    
                }, completion: { fin in
                    completion?(fin)
                })
        }
    }
    
    func switchToMonthlySubscriptions() {
        
        let mutableAttributedString = NSMutableAttributedString()
        
        mutableAttributedString.append(
            NSAttributedString(string: "trySevenDays.free.month.text".localized, attributes: Const.titleAttribute)
        )
        
        mutableAttributedString.append(
            NSAttributedString(string: "switchToYearly.text".localized, attributes: Const.subtitleAttribute)
        )
        
        bottomNode.update(message: mutableAttributedString)
    }
    
    func switchToYearlySubscriptions() {
        let mutableAttributedString = NSMutableAttributedString()
        
        mutableAttributedString.append(
            NSAttributedString(string: "trySevenDays.free.year.text".localized, attributes: Const.titleAttribute)
        )
        
        mutableAttributedString.append(
            NSAttributedString(string: "switchToMonthly.text".localized, attributes: Const.subtitleAttribute)
        )
        
        bottomNode.update(message: mutableAttributedString)
    }
}

