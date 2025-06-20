//
//  Untitled.swift
//  SpriteKitTutorial
//
//  Created by 0-jerry on 6/20/25.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var columns = [[Item]]()
    var itemSize: CGFloat = 50
    var itemPerColumn = 10
    var itemPerRow = 8
    
    // Scene 이 화면에 표시될 때 실행되는 생명주기 메서드
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        let background = SKSpriteNode(imageNamed: "bg001")
        background.position = CGPoint(x: view.frame.width/2,
                                      y: view.frame.height/2)
        background.setScale(3)
        addChild(background)
        
        scene?.size = CGSize(width: view.frame.width,
                             height: view.frame.height)
        
        var itemGrid = [[Item]]()
        for x in 0..<itemPerRow {
            var column = [Item]()
            
            for y in 0..<itemPerColumn {
                let item = createItem(row: y, column: x)
                column.append(item)
            }
            
            itemGrid.append(column)
        }
        columns = itemGrid
    }
    
    func posiotionItem(for item: Item) -> CGPoint {
        let xOffset: CGFloat = ((scene?.size.width ?? 0) - CGFloat(itemPerRow-1) * itemSize) / 2
        let yOffset: CGFloat = 200
        let x = xOffset + itemSize * CGFloat(item.column)
        let y = yOffset + itemSize * CGFloat(item.row)
        
        return CGPoint(x: x, y: y)
    }

    func createItem(row: Int, column: Int, startOffScreen: Bool = false ) -> Item {
        let itemImages = Block.allCases.map { $0.rawValue }
        let randomIndex = GKRandomSource
            .sharedRandom()
            .nextInt(upperBound: itemImages.count)
        let randomImage = itemImages[randomIndex]
        let item = Item(imageNamed: randomImage)
        
        item.name = randomImage
        item.row = row
        item.column = column
        item.position = posiotionItem(for: item)
        item.size = CGSize(width: itemSize, height: itemSize)
        addChild(item)
        
        return item
    }
}

class Item: SKSpriteNode {
    var column = -1
    var row = -1
}
