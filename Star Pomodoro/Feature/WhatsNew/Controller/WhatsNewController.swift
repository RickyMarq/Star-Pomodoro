//
//  WhatsNewController.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 30/08/23.
//

import UIKit

class WhatsNewController: UIViewController {
    
    var whatsNewsView: WhatsNewView?
    var viewModel: WhatsNewViewModel?
    
    override func loadView() {
        self.whatsNewsView = WhatsNewView()
        self.view = whatsNewsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = WhatsNewViewModel()
        self.whatsNewsView?.whatsNewTableView.rowHeight = UITableView.automaticDimension
        self.whatsNewsView?.whatsNewTableView.estimatedRowHeight = 150
        self.configNavigationController()
        self.whatsNewsView?.whatsNewTableViewProtocols(delegate: self, dataSource: self)
    }
    
    func configNavigationController() {
        self.title = "What's New"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension WhatsNewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.count ?? 0
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.titleForSection(section: section) ?? ""
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = viewModel?.cellRowBySection(indexPath: indexPath)
        
        switch index {
        case .whatsNewCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WhatsNewCell.identifier, for: indexPath) as? WhatsNewCell else {return UITableViewCell()}
            cell.configCell(with: model)
            return cell
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
