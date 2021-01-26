//
//  Toast.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/26/21.
//

import Foundation
import MaterialComponents.MaterialSnackbar

enum ToastType {
    case error
    case info
}
class Toast {
    
    static func showHint(type: ToastType, messageTitle: String, actionTitle: String) {
        let message = MDCSnackbarMessage(text: messageTitle)
        let action = MDCSnackbarMessageAction()
        action.title = actionTitle
        message.action = action
        MDCSnackbarManager.default.messageTextColor = AppColors.textPrimaryColor
        
        switch type {
        case .error:
            MDCSnackbarManager.default.snackbarMessageViewBackgroundColor = .red
        case .info:
            MDCSnackbarManager.default.snackbarMessageViewBackgroundColor = AppColors.darkPrimaryColor
        }
        
        MDCSnackbarManager.default.show(message)
    }
}
