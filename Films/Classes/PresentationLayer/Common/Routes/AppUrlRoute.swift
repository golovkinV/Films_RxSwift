import UIKit

public enum AppUrl {
    case phone(String)
    case web(String)
    case email(String)
    case settings
}

protocol AppUrlRoute {
    func open(url: AppUrl)
}

extension AppUrlRoute where Self: RouterProtocol {
    func open(url: AppUrl) {
        switch url {
        case let .phone(value):
            if let number = value.stringByAddingPercentEncodingForURLQueryValue(),
                let url = URL(string: "tel:\(number)") {
                self.open(url: url)
                return
            }
        case let .web(value):
            if let url = value.toURL() {
                self.open(url: url)
                return
            }
        case let .email(value):
            if let url = URL(string: "mailto:\(value)") {
                self.open(url: url)
                return
            }
        case .settings:
            if let url = URL(string: UIApplication.openSettingsURLString) {
                self.open(url: url)
                return
            }
        }
        self.failToast()
    }

    private func open(url: URL) {
        UIApplication.shared.open(url, options: [:]) { success in
            if !success {
                self.failToast()
            }
        }
    }

    private func failToast() {
        let alert = UIAlertController(title: "Не удалось открыть",//L10n.Alert.Message.notOpened,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        ToastModalRouter(target: alert).move()
    }
}
