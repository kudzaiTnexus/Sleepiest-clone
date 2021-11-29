//
//  HeaderNode.swift
//  Sleepiest-Clone
//
//  Created by Kudzaiishe Mhou on 2021/11/26.
//

import AsyncDisplayKit
import Then

final class HeaderNode: ASDisplayNode {
    
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: CustomFont.montserratSemiBold, size: 30)?.withWeight(.medium) as Any]
        }
    }
    
    // MARK: UI
    private let titleTextNode = ASTextNode().then {
        $0.maximumNumberOfLines = 2
    }

    private let subscriptionNode = SubscriptionNode().then {
        $0.backgroundColor = .lightGray.withAlphaComponent(0.6)
        $0.cornerRadius = 15
        $0.style.preferredSize = CGSize(width: 190, height: 30)
    }
    
    // MARK: Initializing
    init(title: String, trialPeriod: String) {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        
        titleTextNode.attributedText = NSAttributedString(string: title, attributes: Const.titleAttribute)
        titleTextNode.accessibilityLabel = title
        
        subscriptionNode.configureView(with: trialPeriod)
    }
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        
        let subscriptionNodeLayoutSpec = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .start,
            alignItems: .start,
            children: [subscriptionNode.styled({ $0.spacingBefore = -4 })]
        )
        
        let bottomLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 20.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [titleTextNode, subscriptionNodeLayoutSpec]
        )
        
        return ASInsetLayoutSpec(insets: .zero, child: bottomLayout)
    }
}
