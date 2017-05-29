//
//  LanguageHelper.swift
//  GithubDemo
//
//  Created by apple on 5/29/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit
class LanguageHelper {
    private static let _instance = LanguageHelper()
    public static var Instance: LanguageHelper {
        return _instance
    }
    
    let APPLE_LANGUAGE_KEY = "AppleLanguages"
    /// get current Apple language
    func currentAppleLanguage() -> String{
        return UserDefaults.standard.array(forKey: APPLE_LANGUAGE_KEY)?.first as! String
    }
    func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang, currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
}


extension UIViewController {
    func showLocalizeDialog(){
        let dialog = UIAlertController(title: "change_language_title".localized(), message: "change_language_message".localized()
            , preferredStyle: UIAlertControllerStyle.actionSheet)
        let cancel = UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil)
        let english = UIAlertAction(title: "english".localized(), style: .default) { _ in
            LanguageHelper.Instance.setAppleLAnguageTo(lang: "en") }
        let vietnamese = UIAlertAction(title: "vietnamese".localized(), style: .default) { _ in
            LanguageHelper.Instance.setAppleLAnguageTo(lang: "vi") }
        dialog.addAction(english)
        dialog.addAction(vietnamese)
        dialog.addAction(cancel)
        present(dialog, animated: true, completion: nil)
    }
}
