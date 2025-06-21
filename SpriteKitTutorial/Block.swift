//
//  SKSpriteNode+Extension.swift
//  SpriteKitTutorial
//
//  Created by 0-jerry on 6/20/25.
//

import GameplayKit

enum Block: String, CaseIterable {
    case blue
    case purple
    case green
    case orange
    
    static var random: Block {
        let blocks = Block.allCases
        let randomIndex = GKRandomSource
            .sharedRandom()
            .nextInt(upperBound: blocks.count)
        return blocks[randomIndex]
    }
}
