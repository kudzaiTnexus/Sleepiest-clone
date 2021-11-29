//
//  LoadingNode.swift
//  Sleepiest-Clone
//
//  Created by Kudzaiishe Mhou on 2021/11/27.
//

import AsyncDisplayKit

final class LoadingNode: ASDisplayNode {
    
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [
                .font: UIFont(name: CustomFont.montserratSemiBold, size: 18)?.withWeight(.medium) as Any,
                .foregroundColor: UIColor.white
            ]
        }
    }
    
    private let activityIndicatorNode = ActivityIndicatorNode(style: .large).then {
        $0.isHidden = true
        $0.isAnimating = false
        $0.color = .white
        $0.style.preferredSize.height = 30
    }
    
    private let titleNode = ASTextNode().then {
        $0.maximumNumberOfLines = 1
        $0.attributedText = NSAttributedString(
            string: "loadingIndicator.greatSleep.description".localized,
            attributes: Const.titleAttribute
        )
    }
    
    var isLoading: Bool = false {
        didSet {
            titleNode.isHidden = !isLoading
            activityIndicatorNode.isAnimating = isLoading
        }
    }
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.backgroundColor = .clear
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec (
            insets: .zero,
            child: contentAreaLayoutSpec()
        )
    }
    
    private func contentAreaLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 16.0,
            justifyContent: .center,
            alignItems: .center,
            children: [activityIndicatorNode, titleNode]
        )
    }
    
    func updateMeggase() {
        titleNode.attributedText = NSAttributedString(
            string: "loadingIndicator.SleepBetter.description".localized,
            attributes: Const.titleAttribute
        )
    }
    
    override func animateLayoutTransition(_ context: ASContextTransitioning) {
        self.alpha = 0
        self.transform = CATransform3DMakeTranslation(0, 20, 0)
        
        UIView.animate(
            withDuration: 1.8,
            delay: 0.8 ,
            options: [.curveEaseInOut],
            animations: {
                let transformTrans = CATransform3DMakeTranslation(1, -3, 1)
                self.transform = transformTrans
                self.alpha = 1
                context.completeTransition(true)
            })
    }
}
