//
//  SubscriptionNode.swift
//  Sleepiest-Clone
//
//  Created by Kudzaiishe Mhou on 2021/11/26.
//

import AsyncDisplayKit
import Then

final class SubscriptionNode: ASCellNode {
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [.font:  UIFont(name: CustomFont.montserratSemiBold, size: 16)?.withWeight(.medium) as Any,
                    .foregroundColor: UIColor.white]
        }
        
        static let insets: UIEdgeInsets =
            .init(top: 13.0, left: 18.0, bottom: 13.0, right: 13.0)
    }
    
    private let imageNode = ASImageNode().then {
        $0.style.preferredSize = CGSize(width: 24, height: 24)
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "circular-check-mark")
        $0.displaysAsynchronously = false
    }
    
    private let titleNode = ASTextNode().then {
        $0.maximumNumberOfLines = 1
    }
    
    override init() {
        super.init()
        
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec (
            insets: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 10),
            child: contentAreaLayoutSpec()
        )
    }
    
    private func contentAreaLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 16.0,
            justifyContent: .start,
            alignItems: .center,
            children: [imageNode, titleNode]
        )
    }
    
    func configureView(with title: String) {
        titleNode.attributedText = NSAttributedString(
            string: title,
            attributes: Const.titleAttribute
        )
    }
}
