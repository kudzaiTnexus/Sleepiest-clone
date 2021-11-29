//
//  BulletsPointNode.swift
//  Sleepiest-Clone
//
//  Created by Kudzaiishe Mhou on 2021/11/28.
//

import AsyncDisplayKit
import Then

public final class BulletsPointNode: ASTableNode, ASTableDelegate, ASTableDataSource {
    
    private let items: [String]
    
    init(_ items: [String]) {
        self.items = items
        
        super.init(style: .plain)
        setupASTableNode()
    }
    
    public override func didLoad() {
        super.didLoad()
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
    }
    
    private func setupASTableNode() {
        delegate = self
        dataSource = self
        style.width = .init(unit: .fraction, value: 1)
        style.flexGrow = 1
        automaticallyManagesSubnodes = true
        automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    public func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            BulletPointNode(title: self.items[indexPath.row], image: "green-check-mark")
        }
    }
    
    public func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        node.transform = CATransform3DMakeTranslation(1, 100, 1)
        node.alpha = 0
        
        UIView.animate(
            withDuration: 1.0,
            delay: 0.5 * Double(node.indexPath?.row ?? 1),
            options: [.curveEaseInOut],
            animations: {
                let transformTranslate = CATransform3DMakeTranslation(1, 1, 1)
                node.transform = transformTranslate
                node.alpha = 1
            })
    }
}
