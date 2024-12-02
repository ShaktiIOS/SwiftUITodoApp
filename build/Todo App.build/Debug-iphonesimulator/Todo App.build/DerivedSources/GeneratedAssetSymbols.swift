import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ColorResource {

    /// The "ColorBackground" asset catalog color resource.
    static let colorBackground = DeveloperToolsSupport.ColorResource(name: "ColorBackground", bundle: resourceBundle)

    /// The "ColorBase" asset catalog color resource.
    static let colorBase = DeveloperToolsSupport.ColorResource(name: "ColorBase", bundle: resourceBundle)

}

// MARK: - Image Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ImageResource {

    /// The "illustration-no1" asset catalog image resource.
    static let illustrationNo1 = DeveloperToolsSupport.ImageResource(name: "illustration-no1", bundle: resourceBundle)

    /// The "illustration-no2" asset catalog image resource.
    static let illustrationNo2 = DeveloperToolsSupport.ImageResource(name: "illustration-no2", bundle: resourceBundle)

    /// The "illustration-no3" asset catalog image resource.
    static let illustrationNo3 = DeveloperToolsSupport.ImageResource(name: "illustration-no3", bundle: resourceBundle)

    /// The "todo-app-logo" asset catalog image resource.
    static let todoAppLogo = DeveloperToolsSupport.ImageResource(name: "todo-app-logo", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// The "ColorBackground" asset catalog color.
    static var colorBackground: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .colorBackground)
#else
        .init()
#endif
    }

    /// The "ColorBase" asset catalog color.
    static var colorBase: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .colorBase)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// The "ColorBackground" asset catalog color.
    static var colorBackground: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .colorBackground)
#else
        .init()
#endif
    }

    /// The "ColorBase" asset catalog color.
    static var colorBase: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .colorBase)
#else
        .init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    /// The "ColorBackground" asset catalog color.
    static var colorBackground: SwiftUI.Color { .init(.colorBackground) }

    /// The "ColorBase" asset catalog color.
    static var colorBase: SwiftUI.Color { .init(.colorBase) }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    /// The "ColorBackground" asset catalog color.
    static var colorBackground: SwiftUI.Color { .init(.colorBackground) }

    /// The "ColorBase" asset catalog color.
    static var colorBase: SwiftUI.Color { .init(.colorBase) }

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "illustration-no1" asset catalog image.
    static var illustrationNo1: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .illustrationNo1)
#else
        .init()
#endif
    }

    /// The "illustration-no2" asset catalog image.
    static var illustrationNo2: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .illustrationNo2)
#else
        .init()
#endif
    }

    /// The "illustration-no3" asset catalog image.
    static var illustrationNo3: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .illustrationNo3)
#else
        .init()
#endif
    }

    /// The "todo-app-logo" asset catalog image.
    static var todoAppLogo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .todoAppLogo)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "illustration-no1" asset catalog image.
    static var illustrationNo1: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .illustrationNo1)
#else
        .init()
#endif
    }

    /// The "illustration-no2" asset catalog image.
    static var illustrationNo2: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .illustrationNo2)
#else
        .init()
#endif
    }

    /// The "illustration-no3" asset catalog image.
    static var illustrationNo3: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .illustrationNo3)
#else
        .init()
#endif
    }

    /// The "todo-app-logo" asset catalog image.
    static var todoAppLogo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .todoAppLogo)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ColorResource {

    private init?(thinnableName: String, bundle: Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ImageResource {

    private init?(thinnableName: String, bundle: Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

