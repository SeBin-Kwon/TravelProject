//
//  UIViewController+Extension].swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/6/25.
//

import UIKit

extension UIViewController {
    
    func screen() -> UIScreen? {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return view.window?.windowScene?.screen
        }
        return window.screen
    }
    
    func displayDeleteAlert(_ handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "정말 삭제하시겠습니까?", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .destructive, handler: handler)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: handler)
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
