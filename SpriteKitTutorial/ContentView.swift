//
//  ContentView.swift
//  SpriteKitTutorial
//
//  Created by 0-jerry on 6/20/25.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    private var game: SKScene = GameScene()
    
    var body: some View {
        SpriteView(scene: game)
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
