//
//  Item.swift
//  SpriteKitTutorial
//
//  Created by 0-jerry on 6/21/25.
//

import SpriteKit

class Item: SKSpriteNode {
    var row: Int
    var column: Int
    var block: Block
    
    init(block: Block = Block.random,
         row: Int,
         column: Int,
         itemSize: CGSize) {
        self.row = row
        self.column = column
        self.block = block
        
        let texture = SKTexture(imageNamed: block.rawValue)
        super.init(texture: texture, color: .clear, size: itemSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
