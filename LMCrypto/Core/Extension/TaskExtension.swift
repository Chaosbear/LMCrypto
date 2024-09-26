//
//  TaskExtension.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 26/9/2567 BE.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}
