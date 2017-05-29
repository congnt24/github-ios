//
//  DialogUtils.swift
//  GithubDemo
//
//  Created by apple on 5/28/17.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showDialog(_ title: String, _ message: String){
        let dialog = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        dialog.addAction(ok)
        present(dialog, animated: true, completion: nil)
    }
}
