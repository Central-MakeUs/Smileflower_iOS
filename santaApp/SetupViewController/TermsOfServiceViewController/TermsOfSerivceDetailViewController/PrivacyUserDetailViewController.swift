//
//  TermsOfServiceDetailViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/25.
//

import UIKit
import PDFKit

class PrivacyUserDetailViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setPDFView()
    }
    let pdfView = PDFView()
    func setPDFView() {
        view.addSubview(pdfView)
        pdfView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let urlString = "https://github.com/Central-MakeUs/Smileflower_Server/files/6874023/27512119f26490cc.pdf"
        if let url = URL(string: urlString),  let document = PDFDocument(url: url)  {
            loadPdfView(document: document)
        }
    }
    func loadPdfView(document: PDFDocument) {
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.document = document
    }
}
