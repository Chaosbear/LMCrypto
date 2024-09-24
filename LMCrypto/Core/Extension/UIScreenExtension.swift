//
//  UIScreenExtension.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import UIKit

extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.windowScene?.screen
    }

    func deviceWidth() -> CGFloat {
        return min(bounds.width, bounds.height)
    }

    func deviceHeight() -> CGFloat {
        return max(bounds.width, bounds.height)
    }

    func screenWidth() -> CGFloat {
        return bounds.width
    }

    func screenHeight() -> CGFloat {
        return bounds.height
    }
}

extension UIWindow {
    static var safeAreaInsets: UIEdgeInsets {
        current?.safeAreaInsets ?? .init(top: 0, left: 0, bottom: 0, right: 0)
    }

    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            return windowScene.windows.first(where: { $0.isKeyWindow })
        }
        return nil
    }
}
