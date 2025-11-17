//
//  CenterViewController.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import UIKit
import SnapKit

class CenterViewController: BaseViewController {
    
    lazy var centerView: CenterView = {
        let centerView = CenterView()
        return centerView
    }()
    
    let viewModel = CenterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCenterInfo()
    }
    
}

extension CenterViewController {
    
    private func getCenterInfo() {
        let customernumber = UserDefaults.standard.object(forKey: WDY_CUSTOMERNUMBER) as? String ?? ""
        let json = ["customernumber": customernumber]
        
        Task { [weak self] in
            guard let self = self else { return }
            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    do { let model = try await self.viewModel.getCenterInitApi(with: json) }
                    catch { print(error) }
                }
                group.addTask {
                    do { let model = try await self.viewModel.judegChnnelpartnerApi(with: json) }
                    catch { print(error) }
                }
            }
        }
    }
    
}
