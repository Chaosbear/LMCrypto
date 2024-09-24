//
//  LaunchScreenView.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import SwiftUI

// we don't want to sleep in AppDelegate didFinishLaunchingWithOptions to delay LaunchScreen
// so we use alternative view that is the same as LaunchScreen StoryBoard to display
// after StoryBoard is disappeared and then delay alternative view instead
struct LaunchScreenView: View {
    var body: some View {
        Image("launch-screen-icon")
            .resizable()
            .frame(width: 100, height: 100)
            .frameExpand(alignment: .center)
            .ignoresSafeArea(.all)
            .background(.white)
    }
}
