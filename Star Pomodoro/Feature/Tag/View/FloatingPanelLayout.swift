//
//  FloatingPanelLayout.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 25/09/23.
//

import Foundation
import FloatingPanel

class TagViewFloatingPanelLayout: FloatingPanelLayout {
    
    let position: FloatingPanel.FloatingPanelPosition = .bottom
    
    let initialState: FloatingPanel.FloatingPanelState = .tip
    
    let anchors: [FloatingPanel.FloatingPanelState : FloatingPanel.FloatingPanelLayoutAnchoring] = [.tip: FloatingPanelLayoutAnchor(absoluteInset: 70.0, edge: .bottom, referenceGuide: .safeArea),
]
        
}
