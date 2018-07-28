//
//  RoomListViewController.swift
//  MORO
//
//  Created by 김재희 on 2018. 7. 28..
//  Copyright © 2018년 김재희. All rights reserved.
//

import UIKit
import SnapKit

class RoomListViewController: UIViewController {
    private var backgroundImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "backgroundShort")
        
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        var tableView: UITableView = UITableView.init(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset.left = 10000
        tableView.register(TimeHeaderTableViewCell.self, forCellReuseIdentifier: "TimeHeaderTableViewCell")
        tableView.register(TimeMainListTableViewCell.self, forCellReuseIdentifier: "TimeMainListTableViewCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        addConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func addSubViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(tableView)
    }
    
    private func addConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension RoomListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0, let headerCell = tableView.dequeueReusableCell(withIdentifier: "TimeHeaderTableViewCell", for: indexPath) as? TimeHeaderTableViewCell {
            return headerCell }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimeMainListTableViewCell", for: indexPath) as? TimeMainListTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}
