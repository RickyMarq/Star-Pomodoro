//
//  SettingsModel.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 27/08/23.
//

import Foundation
import UIKit

struct Section {
    let title: String?
    let cell: [CellType]
}

enum CellType {
    case staticCell(model: StaticCellModel)
    case informationCell(model: InformationCellModel)
    case documentationCell(model: DocumentationCellModel)
    case WhatsNew(model: WhatsNewModelType)
    case notificationCell(model: NotificationModel)
    case phraseCell(model: PhraseCellModel)
}

struct PhraseCellModel {
    let title: String
    let isSelected: Bool
}

struct StaticCellModel {
    let title: String
    let icon: UIImage
    let iconBackgroundColor: UIColor
    let handler: ((_ doubleHeader: String) -> Void)
}

struct DocumentationCellModel {
    let title: String
    let icon: UIImage
    let iconBackgroundColor: UIColor
    let link: String
    let handler: ((_ doubleHeader: String) -> Void)
}

struct InformationCellModel {
    let title: String
    let icon: UIImage
    let iconBackgroundColor: UIColor
    let infoText: String
    let handler: ((_ doubleHeader: String) -> Void)
}

struct WhatsNewModelType {
    let title: String
    let icon: UIImage
    let iconBackgroundColor: UIColor
    let handler: ((_ doubleHeader: String) -> Void)
}

struct NotificationModel {
    let tag: Int
    let title: String
    let icon: UIImage
    let iconBackgroundColor: UIColor
    let isOn: Bool
    let handler: ((_ doubleHeader: String) -> Void)
}
