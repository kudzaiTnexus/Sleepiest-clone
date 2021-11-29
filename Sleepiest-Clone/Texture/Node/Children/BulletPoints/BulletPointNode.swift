//
//  BulletPointNode.swift
//  Sleepiest-Clone
//
//  Created by Kudzaiishe Mhou on 2021/11/25.
//

import AsyncDisplayKit
import Then

final class BulletPointNode: ASCellNode {
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [.font:  UIFont(name: CustomFont.montserratSemiBold, size: 16)?.withWeight(.medium) as Any,
                    .foregroundColor: UIColor.white]
        }
        
        static let insets: UIEdgeInsets =
            .init(top: 13.0, left: 18.0, bottom: 13.0, right: 13.0)
    }
    
    private let imageNode = ASImageNode().then {
        $0.style.preferredSize = CGSize(width: 20, height: 20)
        $0.contentMode = .scaleAspectFit
        $0.accessibilityLabel = "bulletPoint.tickBullet.description.text".localized
        $0.displaysAsynchronously = false
    }
    
    private let titleNode = ASTextNode().then {
        $0.maximumNumberOfLines = 1
    }
    
    init(title: String, image: String) {
        super.init()
        automaticallyManagesSubnodes = true
        automaticallyRelayoutOnSafeAreaChanges = true
        selectionStyle = .none
        backgroundColor = .clear
        titleNode.attributedText = NSAttributedString(string: title,
                                                      attributes: Const.titleAttribute)
        titleNode.accessibilityLabel = title
        imageNode.image = UIImage(named: image)
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec (
            insets: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0),
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
}
