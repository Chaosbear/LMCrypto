//
//  Utils.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import Foundation

struct Utils {
    // MARK: - Number Format
    static func numberFormatter(
        withNumber value: Any,
        style: NumberFormatter.Style = .decimal,
        decimal: Int = 0
    ) -> String {
        guard let number = Double(String(describing: value)) else { return "Invalid Input format or Type" }

        let formatter = NumberFormatter()
        formatter.numberStyle = style
        formatter.maximumFractionDigits = decimal
        formatter.minimumFractionDigits = decimal
        guard let message = formatter.string(for: number) else { return "n/a" }
        return message
    }

    enum SIPrefixs: Double, CaseIterable {
        case yotta = 24
        case zetta = 21
        case exa = 18
        case peta = 15
        case tera = 12
        case giga = 9
        case mega = 6
        case kilo = 3
        case hecto = 2
        case deca = 1
        case none = 0
        case deci = -1
        case centi = -2
        case milli = -3
        case micro = -6
        case nano = -9
        case pico = -12
        case femto = -15
        case atto = -18
        case zepto = -21
        case yocto = -24

        var symbol: String {
            switch self {
            case .yotta: return "Y"
            case .zetta: return "Z"
            case .exa: return "E"
            case .peta: return "P"
            case .tera: return "T"
            case .giga: return "G"
            case .mega: return "M"
            case .kilo: return "k"
            case .hecto: return "h"
            case .deca: return "da"
            case .none: return ""
            case .deci: return "d"
            case .centi: return "c"
            case .milli: return "m"
            case .micro: return "μ"
            case .nano: return "n"
            case .pico: return "p"
            case .femto: return "f"
            case .atto: return "a"
            case .zepto: return "z"
            case .yocto: return "y"
            }
        }
    }

    static func numberFormatterWithSIPrefix(
        withNumber value: Any,
        notUsedPrefixPowerNumberRange: [Int] = Array(0...3),
        minPrefix: SIPrefixs = .nano,
        maxPrefix: SIPrefixs = .yotta,
        decimalPlaces: Int = 1,
        roundRule: FloatingPointRoundingRule = .toNearestOrAwayFromZero,
        unit: String? = nil,
        showZeroDecimal: Bool = false
    ) -> String {
        guard maxPrefix.rawValue > minPrefix.rawValue else { return "maxPrefix must be greater than minPrefix" }
        guard let number = Double(String(describing: value)) else { return "Invalid Input format or Type" }

        var finalString = ""
        // prevent crash from log10(0), and number < 0
        let powerNum: Double = (number == 0) ? 0 : log10(abs(number))
        let prefixList = SIPrefixs.allCases
            .filter { $0.rawValue >= minPrefix.rawValue && $0.rawValue <= maxPrefix.rawValue }
            .map { $0.rawValue }
            .sorted()
        var selectedPrefix: SIPrefixs?

        if notUsedPrefixPowerNumberRange.contains(Int(powerNum.rounded(.towardZero))) {
            finalString = numberFormatter(withNumber: value, style: .decimal, decimal: decimalPlaces)
            if let unit = unit {
                finalString += unit
            }
            return finalString
        }

        for i in 0..<prefixList.count {
            if i == 0 && powerNum <= prefixList[i] {
                selectedPrefix = SIPrefixs.init(rawValue: prefixList[i])
                break
            } else if i < prefixList.count - 1 {
                if powerNum >= prefixList[i] && powerNum < prefixList[i + 1] {
                    selectedPrefix = SIPrefixs.init(rawValue: prefixList[i])
                    break
                }
            } else if i == prefixList.count - 1 && powerNum >= prefixList[i] {
                selectedPrefix = SIPrefixs.init(rawValue: prefixList[i])
                break
            }
        }

        var finalNum = number / pow(10, selectedPrefix?.rawValue ?? 1.0)

        // round number because Double/Double has a slight difference from actual value
        finalNum = (finalNum * pow(10, Double(decimalPlaces + 3))).rounded() / pow(10, Double(decimalPlaces + 3))

        // round number to desired decimal
        finalNum = (finalNum * pow(10, Double(decimalPlaces))).rounded(roundRule) / pow(10, Double(decimalPlaces))

        if !showZeroDecimal && (finalNum - finalNum.rounded(.towardZero)) == 0.0 {
            finalString = "\(numberFormatter(withNumber: Int(finalNum), style: .decimal, decimal: decimalPlaces))\(selectedPrefix?.symbol ?? "")"
        } else {
            finalString = "\(numberFormatter(withNumber: finalNum, style: .decimal, decimal: decimalPlaces))\(selectedPrefix?.symbol ?? "")"
        }

        if let unit = unit {
            finalString += unit
        }

        return finalString
    }

    // MARK: - Date Time Format
    enum DateFormatInput {
        case iso8601
        case date

        var value: String {
            switch self {
            case .iso8601: return "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            case .date: return "yyyy-MM-dd"
            }
        }
    }

    enum DateFormatOutput {
        case dateTime, date, time
        case custom(String)

        var value: String {
            switch self {
            case .dateTime: return "d MMM yy / HH:mm"
            case .date: return "d MMM yy"
            case .time: return "HH:mm"
            case .custom(let format): return format
            }
        }
    }

    enum DateFormatLocale {
        case input
        case output

        var identifier: String {
            switch self {
            case .input: return "en_US_POSIX"
            case .output: return Calendar.autoupdatingCurrent.locale?.identifier ?? "en_US_POSIX"
            }
        }
    }

    static func iso8601DateFormat(
        format: DateFormatInput = .iso8601,
        locale: String = DateFormatLocale.input.identifier
    ) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: locale)
        formatter.dateFormat = format.value
        return formatter
    }

    static func date(
        from dateStr: String,
        format: DateFormatInput = .iso8601,
        locale: String = DateFormatLocale.input.identifier
    ) -> Date? {
        let formatter = iso8601DateFormat(format: format,locale: locale)
        return formatter.date(from: dateStr)
    }

    static func dateFormat(
        from dateStr: String,
        inFormat: DateFormatInput = .iso8601,
        outFormat: DateFormatOutput,
        inLocale: String = DateFormatLocale.input.identifier,
        outLocale: String = DateFormatLocale.output.identifier
    ) -> String? {
        let formatter = iso8601DateFormat(format: inFormat, locale: inLocale)
        guard let date = formatter.date(from: dateStr) else { return nil }

        formatter.locale = Locale(identifier: DateFormatLocale.output.identifier)
        formatter.dateFormat = outFormat.value

        return formatter.string(from: date)
    }

    static func dateFormat(
        from date: Date,
        inFormat: DateFormatInput = .iso8601,
        outFormat: DateFormatOutput,
        inLocale: String = DateFormatLocale.input.identifier,
        outLocale: String = DateFormatLocale.output.identifier
    ) -> String {
        let formatter = iso8601DateFormat(format: inFormat, locale: inLocale)
        formatter.locale = Locale(identifier: outLocale)
        formatter.dateFormat = outFormat.value

        return formatter.string(from: date)
    }
}
