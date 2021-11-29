//
//  BottomNode.swift
//  Sleepiest-Clone
//
//  Created by Kudzaiishe Mhou on 2021/11/25.
//
import UIKit
import AsyncDisplayKit
import Combine
import Then

final class BottomNode: ASDisplayNode {
    
    enum Subscriptions {
        case monthly
        case yearly
    }
    
    @Published private (set) var subscriptionType: Subscriptions = .monthly
    
    // MARK: UI
    private let messageNode = ASTextNode().then {
        $0.maximumNumberOfLines = 2
    }
    
    let subscribeButtonNode = ASButtonNode().then {
        $0.setTitle("button.tryAndSubscribe.text".localized,
                    with: UIFont(name: CustomFont.montserratSemiBold, size: 16)?.withWeight(.medium),
                    with: .white,
                    for: .normal)
        $0.backgroundColor = Colors.skyBlue
        $0.contentEdgeInsets = UIEdgeInsets(top: 17, left: 0, bottom: 17, right: 0)
        $0.cornerRadius = 25
    }
    
    // MARK: Initializing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        
        messageNode.addTarget(self, action: #selector(performAction), forControlEvents: .touchUpInside)
    }
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {

        let bottomLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 20.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [messageNode, subscribeButtonNode]
        )
        
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0),
            child: bottomLayout
        )
    }
    
    func update(message: NSAttributedString) {
        messageNode.attributedText = message
        messageNode.setNeedsLayout()
    }
    
    @objc func performAction() {
        subscriptionType = subscriptionType == .monthly ? .yearly : .monthly
    }
}
