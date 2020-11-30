//
//  LogInViewController.swift
//  AlarTestApp
//
//  Created by Igor Lungis on 11/29/20.
//

import UIKit

class LogInViewController: UIViewController {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var nameTF: UITextField!
  @IBOutlet weak var passwordTF: UITextField!
  @IBOutlet weak var nextButton: UIButton! {
    didSet {
      nextButton.setBackgroundColor(color: UIColor.systemTeal, forState: .normal)
      nextButton.setBackgroundColor(color: UIColor.lightGray, forState: .disabled)
    }
  }
  @IBOutlet weak var nextButtonBottomSpace: NSLayoutConstraint!
  
  var presenter: LogInPresenter!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    nameTF.delegate = self
    passwordTF.delegate = self
    nextButton.isEnabled = false
    scrollView.hideKeyboardWhenTapped()
    presenter = LogInScreen.Presenter(view: self, router: self)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  @IBAction func nextDidTap(_ sender: Any) {
    guard let nameText = nameTF.text, let passText = passwordTF.text, !nameText.isEmpty, !passText.isEmpty else { return }
    presenter.viewEventDidHappen(.nextWasTapped(nameText, passText))
  }
  
  private func showAlert(message: String) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(okAction)
    self.present(alert, animated: true, completion: nil)
  }
  
}

//MARK: - LogInView protocol
extension LogInViewController: LogInView {
  func showErrorAlert(error: String) {
    showAlert(message: error)
  }
  
}

//MARK: - LogInRouter protocol
extension LogInViewController: LogInRouter {
  
  func goToPagesScreen(code: String) {
    print(#function)
    let vc = storyboard?.instantiateViewController(identifier: "pages") as? PagesViewController
    vc?.code = code
    navigationController?.pushViewController(vc!, animated: true)
  }
  
}

//MARK: - Keyboard animation
extension LogInViewController {
  @objc func keyboardWillShow(notification: NSNotification) {
    view.layoutIfNeeded()
    UIView.animate(withDuration: 1) {
      self.nextButtonBottomSpace.constant = (((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height)!) + 20
      self.view.layoutIfNeeded()
    }
  }
  
  @objc func keyboardWillHide(notification: NSNotification) {
    view.layoutIfNeeded()
       UIView.animate(withDuration: 1) {
         self.nextButtonBottomSpace.constant = 20
         self.view.layoutIfNeeded()
       }
  }
}

//MARK: - Text Field Delegate
extension LogInViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let nameText = nameTF.text, let passText = passwordTF.text, !nameText.isEmpty, !passText.isEmpty {
      nextButton.isEnabled = true
    } else {
      nextButton.isEnabled = false
    }
  }
}
