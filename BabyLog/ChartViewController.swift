//
//  ChartViewController.swift
//  BabyLog
//
//  Created by mj.zhou on 15/3/10.
//  Copyright (c) 2015年 mjstudio. All rights reserved.
//

import UIKIT

class ChartViewController: UIViewController {
    
    let mColor =  UIColor(rgba: "#fc9a3c")
    let wColor = UIColor(rgba: "#4dc47a")

    var lineChart:PNLineChart? = nil
    var pieChart:PNPieChart? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var lblTxt = UILabel(frame: CGRectZero)
        lblTxt.textColor=UIColor.grayColor()
        lblTxt.setTranslatesAutoresizingMaskIntoConstraints(false)

        lblTxt.text="最近7天统计"
        view.addSubview(lblTxt)
        
        var cTop = NSLayoutConstraint(item: lblTxt, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 20)
        var cLeft = NSLayoutConstraint(item: lblTxt, attribute: NSLayoutAttribute.CenterX, relatedBy:NSLayoutRelation.Equal, toItem:view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)

        view.addConstraint(cTop)
        view.addConstraint(cLeft)
        
    }
    
    
    private func setLineChart()
    {
        if lineChart == nil{
            lineChart = PNLineChart(frame: CGRectMake(0, 50, self.view.bounds.width, 200))
            view.addSubview(lineChart!)

        }
        
        var countData = getChartData()
        lineChart!.xLabels = countData.lables
        
        var data = PNLineChartData()
        data.lineWidth = 4
        data.color = mColor
        data.itemCount = UInt(countData.mList.count)
        data.getData = ({(index: UInt)->PNLineChartDataItem in
            var yValue:CGFloat = countData.mList[Int(index)]
            var item = PNLineChartDataItem(y:yValue)
            
            return item
        })
        data.dataTitle="奶粉"
        data.inflexionPointStyle =  PNLineChartPointStyle.Circle
      
        var data1 = PNLineChartData()
        data1.lineWidth = 4
        data1.color = wColor
        data1.itemCount = UInt(countData.wList.count)
        data1.getData = ({(index: UInt)->PNLineChartDataItem in
            var yValue:CGFloat = countData.wList[Int(index)]
            var item = PNLineChartDataItem(y:yValue)
            
            return item
        })
        data1.dataTitle="开水"
        data1.inflexionPointStyle =  PNLineChartPointStyle.Square
        lineChart!.legendStyle = PNLegendItemStyle.Serial
        lineChart!.legendFontSize = 12.0;
        
        lineChart!.chartData=[data,data1]
        lineChart!.strokeChart()
        
        var legend = lineChart!.getLegendWithMaxWidth(200)
        legend.frame = CGRectMake((self.view.frame.width-legend.frame.width)/2,250 , legend.frame.width, legend.frame.height)
        view.addSubview(legend)

    }
    
    private func setPieChart(){
        
        if pieChart != nil{
            pieChart!.removeFromSuperview()
        }
        
        var countData = getChartData()
        
        var pData = PNPieChartDataItem(value: countData.mTotal, color: mColor,description:"奶粉")
        var pData1 = PNPieChartDataItem(value: countData.wTotal, color: wColor, description: "开水")
        
        var x = (view.frame.width-250)/2
        
        pieChart = PNPieChart(frame: CGRectMake(x,300, 250, 250),items: [pData,pData1])
        pieChart!.descriptionTextColor = UIColor.whiteColor()
        pieChart!.strokeChart()
        
        view.addSubview(pieChart!)
    }
    
    private func getChartData()->(lables:[String],mList:[CGFloat],wList:[CGFloat],mTotal:CGFloat,wTotal:CGFloat){
        var dayData = FeedLogService.get7DayLineData()
        var labels = [String]()
        var mList:[CGFloat] = [CGFloat]()
        var wList:[CGFloat] = [CGFloat]()
        var mTotal:CGFloat = 0
        var wTotal:CGFloat = 0
        
        for var i:Int=dayData.mList.count-1;i>=0;i-- {
            labels.append(dayData.mList[i].title)
            mList.append(dayData.mList[i].value)
            mTotal += dayData.mList[i].value
        }
        for var i:Int=dayData.wList.count-1;i>=0;i-- {
            //labels.append(dayData.mList[i].title)
            wList.append(dayData.wList[i].value)
            wTotal += dayData.wList[i].value
        }
        
        return (labels,mList,wList,mTotal,wTotal)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        setLineChart()
        setPieChart()
        println("chart view will apper")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
