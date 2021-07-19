//
//  TableVIew.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/19.
//

import UIKit

extension UITableView {
    func isLast(for indexPath: IndexPath) -> Bool {

            let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
            let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1

            return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
        }
    func placeCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, place: Place, isFromRecentPlace: Bool = false) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! MyCell
        if tableView.isLast(for: indexPath) {
            DispatchQueue.main.async {
                cell.addAboveTheBottomBorderWithColor(color: .common_c42_white)
            }
        }

        return cell
    }
}
