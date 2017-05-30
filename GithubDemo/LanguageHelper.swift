//
//  LanguageHelper.swift
//  GithubDemo
//
//  Created by apple on 5/29/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit
class LanguageHelper {
    static let APPLE_LANGUAGE_KEY = "CongLanguages"
    /// get current Apple language
    class func currentLanguage() -> String? {
        return UserDefaults.standard.string(forKey: APPLE_LANGUAGE_KEY)
    }
    class func setLanguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set(lang, forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
}

extension String {
    func localized() -> String {
        let currentLanguage = LanguageHelper.currentLanguage()
        let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj")
        if let path = path, let bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        }
        return self
    }
}


extension UIViewController {
    func showLocalizeDialog(){
        let dialog = UIAlertController(title: R.string.localizable.change_language_title.key.localized(), message: R.string.localizable.change_language_message.key.localized()
            , preferredStyle: UIAlertControllerStyle.actionSheet)
        let cancel = UIAlertAction(title: R.string.localizable.cancel.key.localized(), style: .cancel, handler: nil)
        let english = UIAlertAction(title: R.string.localizable.english.key.localized(), style: .default) { _ in
            LanguageHelper.setLanguageTo(lang: "en") }
        let vietnamese = UIAlertAction(title: R.string.localizable.vietnamese.key.localized(), style: .default) { _ in
            LanguageHelper.setLanguageTo(lang: "vi") }
        dialog.addAction(english)
        dialog.addAction(vietnamese)
        dialog.addAction(cancel)
        present(dialog, animated: true, completion: nil)
    }
}
