//
//  PagesViewController.swift
//  AlarTestApp
//
//  Created by Igor Lungis on 11/29/20.
//

import UIKit

class PagesViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var presenter: PagesPresenter!
  var code: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter = PagesScreen.Presenter(view: self, router: self, code: self.code)
    presenter.viewEventDidHappen(.loadInfo)
    refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    tableView.addSubview(refreshControl)
  }
  
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  private lazy var refreshControl = UIRefreshControl()
  
  @objc func refresh(_ sender: AnyObject) {
    presenter.places.removeAll()
    presenter.numberOfPage = 0
    presenter.viewEventDidHappen(.loadInfo)
  }

}

//MARK: - PagesView protocol
extension PagesViewController: PagesView {
  
  func render() {
    tableView.reloadData()
    refreshControl.endRefreshing()
  }
  
}

//MARK: - PagesRouter protocol
extension PagesViewController: PagesRouter {
  func goToDetailsScreen(info: PageInfo) {
    print(#function)
    let vc = storyboard?.instantiateViewController(identifier: "details") as? DetailsViewController
    vc?.placeInfo = info
    navigationController?.pushViewController(vc!, animated: true)
  }
}

//MARK: - TableView data source, delegate
extension PagesViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.places.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "pagesCell") as! PagesTableViewCell
    cell.name = presenter.places[indexPath.row].name
    if indexPath.row == presenter.places.count - 1 {
      presenter.viewEventDidHappen(.loadInfo)
    }
    cell.selectionStyle = .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return self.view.frame.width * 0.8
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.viewEventDidHappen(.pageWasTapped(indexPath.row))
  }
  
}
