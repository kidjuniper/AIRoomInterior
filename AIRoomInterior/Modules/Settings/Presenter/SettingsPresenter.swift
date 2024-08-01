//
//  SettingsPresenter.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 30.07.2024.
//

import Foundation
import UIKit

class SettingsPresenter: NSObject {
    weak var viewController: SettingsViewInputProtocol?
    
    // MARK: - Private Properties
    private var tableDataArray: [SettingsTableCellData] = []
    
    // MARK: - Initializer
    init(viewController: SettingsViewInputProtocol) {
        self.viewController = viewController
        
        tableDataArray = [SettingsTableCellData(title: "Share this App",
                                                imageName: "square.and.arrow.up"),
                          SettingsTableCellData(title: "Rate us on App Store",
                                                                  imageName: "hand.thumbsup"),
                          SettingsTableCellData(title: "Terms of Use",
                                                                  imageName: "doc"),
                          SettingsTableCellData(title: "Privacy Policy",
                                                                  imageName: "doc.text")]
    }
}

extension SettingsPresenter: SettingsPresenterProtocol {
    func backButtonPressed() {
        viewController?.goBack()
    }
    
    func cellPresed(indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            processShareBlock(index: indexPath.row)
        default:
            processTNPBlock(index: indexPath.row)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.cellId,
                                                            for: indexPath) as? SettingsTableViewCell
        cell?.configure(withData: tableDataArray[(indexPath.row + (indexPath.section * 2))])
        return cell!
    }
}

extension SettingsPresenter {
    private func processShareBlock(index: Int) {
        switch index {
        case 0:
            return
        default:
            viewController?.showRatingRequest()
        }
    }
    
    private func processTNPBlock(index: Int) {
        
    }
}
