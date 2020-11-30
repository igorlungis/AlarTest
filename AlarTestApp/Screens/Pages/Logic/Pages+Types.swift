//
//  Pages+Types.swift
//  AlarTestApp
//
//  Created by Igor Lungis on 11/29/20.
//

import Foundation

enum PagesScreen {}

protocol PagesView: AnyObject {
  func render()
}

protocol PagesPresenter: AnyObject {
  func viewEventDidHappen(_ event: PagesScreen.Event)
  var places: [PageInfo] { get set }
  var numberOfPage: Int { get set }
}

extension PagesScreen {
  enum Event {
    case loadInfo
    case pageWasTapped(Int)
  }
}

protocol PagesRouter: AnyObject {
  func goToDetailsScreen(info: PageInfo)
}

struct PageInfo {
  var id: String? = nil
  var name: String? = nil
  var country: String? = nil
  var lat: Double? = nil
  var lon: Double? = nil
}

