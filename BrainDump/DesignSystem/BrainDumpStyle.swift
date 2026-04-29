import SwiftUI

enum FN {
    static var ink: Color { Color(UIColor { t in t.userInterfaceStyle == .dark ? UIColor(white: 0.93, alpha: 1) : UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1) }) }
    static var secondary: Color { Color(UIColor { t in t.userInterfaceStyle == .dark ? UIColor(red: 0.65, green: 0.68, blue: 0.73, alpha: 1) : UIColor(red: 0.420, green: 0.447, blue: 0.502, alpha: 1) }) }
    static var tertiary: Color { Color(UIColor { t in t.userInterfaceStyle == .dark ? UIColor(red: 0.44, green: 0.46, blue: 0.52, alpha: 1) : UIColor(red: 0.612, green: 0.639, blue: 0.686, alpha: 1) }) }
    static var line: Color { Color(UIColor { t in t.userInterfaceStyle == .dark ? UIColor(red: 0.20, green: 0.22, blue: 0.26, alpha: 1) : UIColor(red: 0.898, green: 0.906, blue: 0.922, alpha: 1) }) }
    static var surface: Color { Color(UIColor { t in t.userInterfaceStyle == .dark ? UIColor(red: 0.15, green: 0.15, blue: 0.17, alpha: 1) : UIColor(red: 0.969, green: 0.969, blue: 0.980, alpha: 1) }) }
    static var card: Color { Color(UIColor { t in t.userInterfaceStyle == .dark ? UIColor(red: 0.22, green: 0.22, blue: 0.25, alpha: 1) : .white }) }
    static let success = Color(red: 0.114, green: 0.620, blue: 0.459)
}

enum ColorSchemePreference: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var label: String {
        switch self {
        case .system: "Systeem"
        case .light: "Licht"
        case .dark: "Donker"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: nil
        case .light: .light
        case .dark: .dark
        }
    }
}

enum TextSizePreference: String, CaseIterable, Identifiable {
    case small
    case `default`
    case large

    var id: String { rawValue }

    var label: String {
        switch self {
        case .small: "Small"
        case .default: "Default"
        case .large: "Large"
        }
    }

    var scale: CGFloat {
        switch self {
        case .small: 0.88
        case .default: 1
        case .large: 1.16
        }
    }
}

private struct AppTextScaleKey: EnvironmentKey {
    static let defaultValue: CGFloat = 1
}

extension EnvironmentValues {
    var appTextScale: CGFloat {
        get { self[AppTextScaleKey.self] }
        set { self[AppTextScaleKey.self] = newValue }
    }
}

private struct AppFontModifier: ViewModifier {
    @Environment(\.appTextScale) private var scale
    let size: CGFloat
    let weight: Font.Weight

    func body(content: Content) -> some View {
        content.font(.system(size: size * scale, weight: weight))
    }
}

extension View {
    func appFont(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        modifier(AppFontModifier(size: size, weight: weight))
    }
}

func time(_ date: Date) -> String {
    date.formatted(.dateTime.hour(.twoDigits(amPM: .omitted)).minute(.twoDigits).locale(Locale(identifier: "nl_BE")))
}
