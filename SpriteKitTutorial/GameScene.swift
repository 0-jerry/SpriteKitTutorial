//
//  Untitled.swift
//  SpriteKitTutorial
//
//  Created by 0-jerry on 6/20/25.
//

import SpriteKit

class GameScene: SKScene {
    
    private var columns = [[Item]]() {
        // 프로퍼티 옵저버를 통해 아이템의 위치를 업데이트
        didSet {
            updateItems()
            updatePosition()
        }
    }
    private let itemSize: CGFloat = 50
    private let itemPerColumn = 10
    private let itemPerRow = 8
    private var currentMatch = Set<Item>()
    weak var gameManager: GameManager?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        let background = SKSpriteNode(imageNamed: "bg001")
        background.position = CGPoint(x: view.frame.width/2,
                                      y: view.frame.height/2)
        background.setScale(1)
        addChild(background)
        
        scene?.size = CGSize(width: view.frame.width,
                             height: view.frame.height)
        
        setUpItemGrid()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        guard let tappedItem = findItem(point: location) else { return }
        
        countMove()
        findMatch(original: tappedItem)
        removeMatches()
        countScore()
    }
    
    private func countMove() {
        gameManager?.move += 1
    }
    
    private func countScore() {
        gameManager?.score += currentMatch.count
        currentMatch.removeAll()
    }
    
    // Scene 이 화면에 표시될 때 실행되는 생명주기 메서드
    private func setUpItemGrid() {
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
    
    private func posiotionItem(for item: Item) -> CGPoint {
        let xOffset: CGFloat = ((scene?.size.width ?? 0) - CGFloat(itemPerRow-1) * itemSize) / 2
        let yOffset: CGFloat = 200
        let x = xOffset + itemSize * CGFloat(item.column)
        let y = yOffset + itemSize * CGFloat(item.row)
        
        return CGPoint(x: x, y: y)
    }
    
    func createItem(row: Int, column: Int, startOffScreen: Bool = false ) -> Item {
        let item = Item(row: row,
                        column: column,
                        itemSize: .init(width: itemSize,
                                        height: itemSize))
        let position = posiotionItem(for: item)
        item.position = position
        if startOffScreen { item.position.y = size.height }

        addChild(item)

        return item
    }
    
    /// 파라미터 입력 좌표에 해당하는 node를 찾아옴
    /// 해당 노드를 item 으로 타입 검증해 배경을 필터링하고
    /// Item 타입으로의 타입 매칭을 통해, Item 타입의 값을 반환
    private func findItem(point: CGPoint) -> Item? {
        let items = nodes(at: point)
            .compactMap { $0 as? Item }
        
        return items.first
    }
    
    /// 입력된 아이템의 좌표를 통해 매칭되는 아이템들을 확인
    private func findMatch(original: Item) {
        
        currentMatch.insert(original)
        let position = original.position
        
        let checkItems: [Item] = cardinalPoints(position)
            .compactMap { findItem(point: $0) }
        
        //
        for checkItem in checkItems {
            if currentMatch.contains(checkItem) { continue }
            // 같은 아이템인지 검증 후, 재귀를 통해 닿아있는 주변 아이템을 다시 검증
            if original.block == checkItem.block {
                findMatch(original: checkItem)
            }
        }
    }
    
    private func cardinalPoints(_ position: CGPoint) -> [CGPoint] {
        return [
            CGPoint(x: position.x, y: position.y - itemSize),
            CGPoint(x: position.x, y: position.y + itemSize),
            CGPoint(x: position.x - itemSize, y: position.y),
            CGPoint(x: position.x + itemSize, y: position.y)
        ]
    }
    
    private func removeMatches() {
        currentMatch
            .sorted { $0.row > $1.row }
            .forEach {
                columns[$0.column].remove(at: $0.row)
                $0.removeFromParent()
            }
    }
    
    
    private func updateItems() {
        for columnIndex in 0..<itemPerRow {
            for rowIndex in 0..<itemPerColumn {
                // Item의 row Index 수정
                if rowIndex < columns[columnIndex].count {
                    let item = columns[columnIndex][rowIndex]
                    if item.row != rowIndex {
                        item.row = rowIndex
                    }
                // 부족한 Item 보충
                } else {
                    let item = createItem(row: rowIndex,
                                          column: columnIndex,
                                          startOffScreen: true)
                    columns[columnIndex].append(item)
                }
            }
        }
    }
    
    private func updatePosition() {
        columns.forEach { items in
            items.forEach { item in
                moveDown(item)
            }
        }
    }
    
    private func moveDown(_ item: Item) {
        let position = posiotionItem(for: item)
        // Item 의 포지션이 변경된 경우에만 애니메이션 동작
        guard item.position != position else { return }
        let downAction = SKAction.move(to: position,
                                       duration: 0.3)
        item.run(downAction)
    }
    
}
