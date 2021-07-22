//
//  ViewController.swift
//  AllAboutRxSwift
//
//  Created by Sanjay Mali on 21/07/21.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    private var viewModel = ProductViewModel()
    private var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        let themeService = ThemeType.service(initial: .dark)
        themeService.switch(.dark)
//        view.theme.backgroundColor = themeService { $0.backgroundColor }
//        label.theme.textColor = the?meService { $0.textColor }
        let tapGesture = UITapGestureRecognizer()
               view.addGestureRecognizer(tapGesture)
               tapGesture.rx.event.withLatestFrom(themeService.typeStream)
                   .map { $0 == .dark ? .light : .dark }
                   .bind(to: themeService.switcher)
                   .disposed(by: bag)
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        bindTableData()
    }
    func bindTableData(){
//        Bind items to table or CellforRow at indexpath
        viewModel.items.bind(to:tableView.rx.items(
            cellIdentifier: "Cell", cellType: UITableViewCell.self)
        ){ row, model, cell in
            cell.textLabel?.text = model.title
            cell.imageView?.image = UIImage(systemName: model.imageName)
        }.disposed(by: bag)
//        Bind  a model selected handler or didSelect
        tableView.rx.modelSelected(Product.self).bind {
            product in
            print(product.title)
        }.disposed(by: bag)
        
//        fetch items
        viewModel.fetchItems()
    }
}

