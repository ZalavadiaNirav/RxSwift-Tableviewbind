//
//  ViewController.swift
//  reactive
//
//  Created by Nirav Zalavadia on 22/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController,UITableViewDelegate {

    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        return table
    }()
    
    private var viewModel = ProductViewModel()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        bindToTableView()
    }
    
    func bindToTableView()
    {
        // bind item to table
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: "CellIdentifier",cellType: UITableViewCell.self))
        { index,element,cell in
            cell.textLabel?.text = element.title
        }.disposed(by: bag)
        
        //bind a model selected handler
        tableView.rx.modelSelected(Product.self).bind { product in
            print(product.title)
        }.disposed(by: bag)
        
        //fetch items
        viewModel.fetchItem()
    }
}

