import QtQuick 2.0

ListView{
    id:tradeView
    anchors.fill: parent
    ListModel{
        id:tradesModel
    }
    model: 4;//tradesModel
    delegate: YouzanItem{
        height: 400
        width: parent.width
    }
    Component.onCompleted: {
        searchTrades("2016-03-09 00:00:00","2016-05-09 00:00:00")
//        searchTrades("","");
    }

    function searchTrades(startDate,endDate){
        tradesModel.clear();//清空列表
        var request=new XMLHttpRequest();
        var data;
        //监听onreadystatechange事件
        request.onreadystatechange=function(){
            if(request.readyState===request.DONE){
                console.log("-----微信号是多少?---- "+(request.responseText.length));
//                tradesModel.append({});
//                return;
                data=JSON.parse(request.responseText.toString());
                console.log(request.responseText.toString())
                for(var i=0;i<data.response.trades.length;i++){

                    var defference=true;
                    for(var index=0;index<tradesModel.count;index++){
                        if(tradesModel.get(index).tid===data.response.trades[i].tid){
                            defference=false;
                        }
                    }
                    if(defference){
                        var str="";
                        var orders=data.response.trades[i].orders;
                        for(var a=0;a<orders.length;a++){
                            str+=(" "+orders[a].title+"   数量："+orders[a].num+"  单价："+orders[a].price+"元"+"\n\n\n")
                        }

                        var sum=0.0;
                        for(var a=0;a<orders.length;a++){
                            sum+=Number(orders[a].total_fee);
                        }

                        var pay_type;
                        if(data.response.trades[i].pay_type==="WEIXIN"){
                            pay_type="微信支付";
                        }
                        else if(data.response.trades[i].pay_type==="ALIPAY "){
                            pay_type="支付宝支付";
                        }
                        else if(data.response.trades[i].pay_type==="BANKCARDPAY "){
                            pay_type="银行卡支付";
                        }
                        else if(data.response.trades[i].pay_type==="PEERPAY "){
                            pay_type="代付";
                        }
                        else if(data.response.trades[i].pay_type==="CODPAY "){
                            pay_type="货到付款";
                        }
                        else if(data.response.trades[i].pay_type==="BAIDUPAY "){
                            pay_type="百度钱包支付";
                        }
                        else if(data.response.trades[i].pay_type==="PRESENTTAKE "){
                            pay_type="直接领取赠品";
                        }
                        else if(data.response.trades[i].pay_type==="COUPONPAY"){
                            pay_type="优惠券/码全额抵扣";
                        }
                        else if(data.response.trades[i].pay_type==="BULKPURCHASE"){
                            pay_type="来自分销商的采购";
                        }
                        else{
                            pay_type="未知类型"
                        }

                        str+="  应付："+sum.toFixed(2)+"元\n\n"+
                                "  订单创建日期:"+data.response.trades[i].created+"\n\n"+
                                "付款类型："+pay_type;

                        tradesModel.append({"tid":data.response.trades[i].tid,
                                               "orders":data.response.trades[i].orders,
                                               "ordersContent":str,
                                               "trade":data.response.trades[i],
                                               "selected":false});
                        str=""
                    }
                }
            }
        }

        //params
        var startCreated=startDate;
        var endCreadted=endDate;

        var secret="修改";
        var appid="修改";
        var currentDate=new Date();
        var method="kdt.trades.sold.get";//调用第三方接口函数

        var dateString=currentDate.getFullYear().toString()+"-"+
                (currentDate.getMonth()+1<10?"0"+(currentDate.getMonth()+1):currentDate.getMonth()+1)+"-"+
                (currentDate.getDate()<10?"0"+currentDate.getDate():currentDate.getDate())+" "+
                (currentDate.getHours()<10?"0"+currentDate.getHours():currentDate.getHours())+":"+
                (currentDate.getMinutes()<10?"0"+currentDate.getMinutes():currentDate.getMinutes())+":"+
                (currentDate.getSeconds()<10?"0"+currentDate.getSeconds():currentDate.getSeconds());

        //md5验证码
        var md5=Qt.md5(secret+"app_id"+appid+"end_created"+endCreadted+"formatjson"+"method"
                       +method+"sign_methodmd5"+"start_created"+startCreated+"timestamp"+dateString+"v1.0"+secret
                       );

        var url ="https://open.koudaitong.com/api/entry?sign="+md5+"&"+"timestamp="+
                dateString+"&v=1.0&app_id="+appid+"&method="+
                method+"&sign_method=md5&format=json"+
                "&start_created="+startCreated+
                "&end_created="+endCreadted;
        console.log("url is "+url);
        request.open("GET",url);
        request.send();
    }
}


//https://open.koudaitong.com/api/entry?sign=74d4c18b9f077ed998feb10e96c58497
//&timestamp=2013-05-06%2013:52:03&v=1.0&app_id=test&method=kdt.item.get
//&sign_method=md5&format=json&num_iid=383829342

//https://open.koudaitong.com/api/entry?sign=bd1d2813d35e7c6294cc17a7a21c0a5a
//&timestamp=2016-04-09 20:46:38&v=1.0&app_id=e1b70429940cd4aa66&method=kdt.trades.sold.get
//&sign_method=md5&format=json&start_created=2016-03-09 00:00:00&end_created=2016-05-09 00:00:00
