//
//  LogIn+Types.swift
//  AlarTestApp
//
//  Created by Igor Lungis on 11/29/20.
//

import Foundation

enum LogInScreen {}

protocol LogInView: AnyObject {
  func showErrorAlert(error: String)
}

protocol LogInPresenter: AnyObject {
    func viewEventDidHappen(_ event: LogInScreen.Event)
}

extension LogInScreen {
  enum Event {
    case nextWasTapped(String, String)
  }
}

protocol LogInRouter: AnyObject {
  func goToPagesScreen(code: String)
}
