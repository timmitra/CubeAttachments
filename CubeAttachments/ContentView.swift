//
// ---------------------------- //
// Original Project: CubeAttachments
// Created on 2024-09-24 by Tim Mitra
// Mastodon: @timmitra@mastodon.social
// Twitter/X: timmitra@twitter.com
// Web site: https://www.it-guy.com
// ---------------------------- //
// Copyright © 2024 iT Guy Technologies. All rights reserved.
/*
 https://stackoverflow.com/questions/77689616/how-to-create-entity-with-attachment-using-realityview-in-visionos
 */


import SwiftUI
import RealityKit

struct ContentView: View {
    
    @State private var isClicked: Bool = false
    @State private var counter: Int = 0

    var body: some View {
        ZStack {
            
            Button("Add Model with Attachment"){
                counter += 1
                isClicked = true
                Task {
                    try await Task.sleep(nanoseconds: 10_000)
                    isClicked = false
                }
            }.font(.extraLargeTitle).position(x:610, y:30)
            
            RealityView { content, attachments in
                print("Started")
            } update: { content, attachments  in
                if isClicked {
                    var customColor = SimpleMaterial(color: UIColor(red: CGFloat(Float(counter) / 5), green: 0.0, blue: 0.7, alpha: 1.0), isMetallic: false)
                    let box = ModelEntity(mesh: .generateBox(size: 0.1), materials: [customColor])
                    let startX: Float = -0.5

                    box.position.x = startX + (0.15 * Float(counter))
                    //box.position.y = 0.10
                    box.name = "box \(counter)"
                    content.add(box)
                    
                    if let text = attachments.entity(for: "\(counter)") {
                        text.position.x = box.position.x
                        text.position.y = 0.10
                        content.add(text)
                    }
                }
            } attachments: {
                ForEach(0...6, id: \.self) { i in
                    Attachment(id: "\(i)") {
                        Text("Cube \(i)").font(.extraLargeTitle)
                    }
                }
            }
        }

    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
