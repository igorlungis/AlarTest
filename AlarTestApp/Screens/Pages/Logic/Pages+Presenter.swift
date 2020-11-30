//
//  Pages+Presenter.swift
//  AlarTestApp
//
//  Created by Igor Lungis on 11/29/20.
//

import Foundation
import Alamofire
import SwiftyJSON

extension PagesScreen {
  class Presenter: PagesPresenter {
    
    weak var view: PagesView?
    weak var router: PagesRouter?
    var code: String
    var places: [PageInfo] = []
    var numberOfPage = 0
    
    init(view: PagesView, router: PagesRouter, code: String) {
      self.view = view
      self.router = router
      self.code = code
    }
    
    func viewEventDidHappen(_ event: Event) {
      switch event {
      case .pageWasTapped(let index):
        router?.goToDetailsScreen(info: places[index])
      case .loadInfo:
        loadInfo(code: self.code)
      }
    }
    
    private func loadInfo(code: String) {

      let url = "http://www.alarstudios.com/test/data.cgi?code=\(code)&p=\(self.numberOfPage)"

      AF.request(url, method: .get).responseJSON { (response) in
        switch response.result {
        case .success(let value):
          let json: JSON = JSON(value)
          
          let placesArray = json["data"].arrayValue
          
          for item in placesArray {
            var place = PageInfo()
            if let id = item["id"].string {
              place.id = id
            }
            if let name = item["name"].string {
              place.name = name
            }
            if let country = item["country"].string {
              place.country = country
            }
            if let lat = item["lat"].double {
              place.lat = lat
            }
            if let lon = item["lon"].double {
              place.lon = lon
            }
            self.places.append(place)
          }
          print(self.places)
          self.numberOfPage += 1
          self.view?.render()
        case .failure(let error):
          print("error -> \(error)")
          self.view?.render()
        }
      }
    }
  }
}
