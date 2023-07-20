//
//  String+Extensions.swift
//  WeDoItTogether
//
//  Created by 최하늘 on 2023/07/20.
//

import Foundation

extension String {
    //비밀번호 정규식
    func isValidCheckPassword() -> Bool {
        //영문 + 숫자 8~20자
        let str = "^(?=.*[A-Za-z])(?=.*[0-9]).{8,20}"
        let predic = NSPredicate(format: "SELF MATCHES %@", str)
        
        return predic.evaluate(with: self)
    }
}
