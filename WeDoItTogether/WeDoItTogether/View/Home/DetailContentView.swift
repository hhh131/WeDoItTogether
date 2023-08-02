//
//  DetailContentView.swift
//  WeDoItTogether
//
//  Created by 오영석 on 2023/07/21.
//

import UIKit

class DetailContentView: UIView {
    
    lazy var detailContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.shadowRadius = 3
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "WeDoItTogether[25979:833951] void * _Nullable NSMapGet(NSMapTable * _Nonnull, const void * _Nullable): map table argument is NULL"
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "WeDoItTogether[25979:833951] void * _Nullable NSMapGet(NSMapTable * _Nonnull, const void * _Nullable): map table argument is NULL"
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "WeDoItTogether[25979:833951] void * _Nullable NSMapGet(NSMapTable * _Nonnull, const void * _Nullable): map table argument is NULL"
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        
        return label
    }()
    
    lazy var membersLabel: UILabel = {
        let label = UILabel()
        label.text = "WeDoItTogether[25979:833951] void * _Nullable NSMapGet(NSMapTable * _Nonnull, const void * _Nullable): map table argument is NULL"
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        
        return label
    }()
    
    lazy var memoLabel: UILabel = {
        let label = UILabel()
        label.text = "메모"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        
        return label
    }()
    
    lazy var memoContentLabel: UILabel = {
        let label = UILabel()
        label.text = "WeDoItTogether[25979:833951] void * _Nullable NSMapGet(NSMapTable * _Nonnull, const void * _Nullable): map table argument is NULLWeDoItTogether[25979:833951] void * _Nullable NSMapGet(NSMapTable * _Nonnull, const void * _Nullable): map table argument is NULL"
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addView()
        setLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }
    
    func addView() {
        addSubview(detailContentView)
        detailContentView.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel,
         dateLabel, locationLabel, membersLabel,
         memoLabel,
         memoContentLabel].forEach { item in
            detailContentView.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    func setLayoutConstraints() {
        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            detailContentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            detailContentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            detailContentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            detailContentView.heightAnchor.constraint(equalToConstant: 120)
            
            //제목
//            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
//            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
//            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: padding),
//
//        ])
//
//        NSLayoutConstraint.activate([
//
//            locationLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
//            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
//
//            dateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
//            dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
//
//            membersLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
//            membersLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding + 5)
        ])
    }
}
