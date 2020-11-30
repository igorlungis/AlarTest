//
//  LogIn+Presenter.swift
//  AlarTestApp
//
//  Created by Igor Lungis on 11/29/20.
//

import Foundation
import Alamofire
import SwiftyJSON

extension LogInScreen {
  class Presenter: LogInPresenter {
    weak var view: LogInView?
    weak var router: LogInRouter?
    
    init(view: LogInView, router: LogInRouter) {
      self.view = view
      self.router = router
    }
    
    func viewEventDidHappen(_ event: Event) {
      switch event {
      case .nextWasTapped(let name, let pass):
        print("\(name) - \(pass)")
        checkNameAndPass(name: name, pass: pass)
      }
    }
    
    private func checkNameAndPass(name: String, pass: String) {
      
      let url = "http://www.alarstudios.com/test/auth.cgi?username=\(name)&password=\(pass)"
      
      AF.request(url, method: .get).responseJSON { (response) in
        switch response.result {
        case .success(let value):
          let json: JSON = JSON(value)
          let code = json["code"].stringValue
          let status = json["status"].stringValue
          print("code --> \(code) status -> \(status)")
          
          if status == "ok" {
            self.router?.goToPagesScreen(code: code)
          } else {
            self.view?.showErrorAlert(error: "User name and/or password is not correct.")
          }
        case .failure(let error):
          print("error -> \(error)")
          self.view?.showErrorAlert(error: "Network error.")
        }
      }
    }
  }
}


