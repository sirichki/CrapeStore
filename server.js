const express = require('express');
const app = express();
const port = 3000;
const sql = require('mssql/msnodesqlv8');
const config = {
    server :"."
    ,database:"MyCrape"
    ,options:{
        trustedConnection:true
    }
};

const connectionString = "server=.;Database=MyCrape;Trusted_Connection=Yes;Driver={SQL Server Native Client 11.0}";

const query1 = "SELECT PERIODSTATUS FROM TB_PERIODS WHERE PERIOD_ID = (SELECT MAX(PERIOD_ID) FROM TB_PERIODS WHERE PERIODTYPE = 1)";
const qPeriod = 'EXEC GET_PERIOD'
const qPeriod2 = 'EXEC GET_PERIOD2'
const qPeriod3 = 'EXEC GET_PERIOD3'

const openDay = 'EXEC ADD_PERIOD @STS = 0';
const openShift = 'EXEC ADD_PERIOD @STS = 1';
const closeShift = 'UPDATE TB_PERIODS SET PERIODSTATUS = 1,CLOSETIME = GETDATE() WHERE PERIODTYPE = 1 AND PERIODSTATUS = 0';
const closeDay = 'UPDATE TB_PERIODS SET PERIODSTATUS = 1,CLOSETIME = GETDATE() WHERE PERIODTYPE = 0 AND PERIODSTATUS = 0';
const shiftDay = 'EXEC ADD_PERIOD @STS = 3';

const cashDay = "EXEC CASHDAY_REPORT @DATE='";

const addSale = "EXEC INSERT_SALE @STRINGLINE='";
const searchBill = "EXEC SEARCH_BILL @SID=";
const delBill = "UPDATE SALE SET IS_ACTIVE = 0 WHERE SALE_ID = ";

app.use(express.static('public'))
app.use(express.json())

app.get('/delbill/:dynamic', (req, res) => {
    const { dynamic } = req.params
    sql.connect(config,function(err){
        if(err)
            console.log(err);
        var request = new sql.Request();
        request.query(delBill+req.params.dynamic, function(err,record) {
            if(err)
                console.log(err);
            else
                res.send({status: 'recieved'});
        })
    })
})

app.get('/addsale/:dynamic', (req, res) => {
    const { dynamic } = req.params
    sql.connect(config,function(err){
        if(err)
            console.log(err);
        var request = new sql.Request();
        request.query(addSale+req.params.dynamic+"'", function(err,record) {
            if(err)
                console.log(err);
            else
                res.send({status: 'recieved'});
        })
    })
})

app.get('/info/:dynamic', (req, res) => {
    const { dynamic } = req.params
    const { key } = req.query
    sql.connect(config,function(err){
        if(err)
            console.log(err);
        var request = new sql.Request();
        request.query(query1, function(err,record) {
            if(err)
                console.log(err);
            else
                res.send(record);
        })
    })
})

app.get('/period', (req, res) => {
    sql.connect(config,function(err){
        if(err)
            console.log(err);
        var request = new sql.Request();
        request.query(qPeriod, function(err,record) {
            if(err)
                console.log(err);
            else
                res.send(record);
        })
    })
})

app.get('/period2', (req, res) => {
    sql.connect(config,function(err){
        if(err)
            console.log(err);
        var request = new sql.Request();
        request.query(qPeriod2, function(err,record) {
            if(err)
                console.log(err);
            else
                res.send(record);
        })
    })
})

app.get('/period3', (req, res) => {
    sql.connect(config,function(err){
        if(err)
            console.log(err);
        var request = new sql.Request();
        request.query(qPeriod3, function(err,record) {
            if(err)
                console.log(err);
            else
                res.send(record);
        })
    })
})

app.get('/cashday/:dynamic', (req, res) => {
    const { dynamic } = req.params
    sql.connect(config,function(err){
        if(err)
            console.log(err);
        var request = new sql.Request();
        request.query(cashDay+req.params.dynamic+"'", function(err,record) {
            if(err)
                console.log(err);
            else
                res.send(record);
        })
    })
})

app.get('/searchBill/:dynamic', (req, res) => {
    const { dynamic } = req.params
    sql.connect(config,function(err){
        if(err)
            console.log(err);
        var request = new sql.Request();
        request.query(searchBill+req.params.dynamic, function(err,record) {
            if(err)
                console.log(err);
            else
                res.send(record);
        })
    })
})

app.get('/periodManage/:dynamic', (req, res) => {
    const { dynamic } = req.params
    var qix = ''
    switch(req.params.dynamic) {
        case 'openday': qix = openDay;
        break;
        case 'closeday': qix = closeDay;
        break;
        case 'openshift': qix = openShift;
        break;
        case 'closeshift': qix = closeShift;
        break;
        case 'shiftday': qix = shiftDay;
        break;
        default: qix = 'error xx';
    }
    //console.log(req.params,qix);
    //res.send({status: 'recieved'});
    sql.connect(config,function(err){
        if(err)
            console.log(err);
        var request = new sql.Request();
        request.query(qix, function(err,record) {
            if(err)
                console.log(err);
            else
                res.send({status: 'recieved'});
        })
    })
})

app.post('/', (req,res) => {
    const {parcel} = req.body
    //console.log(parcel)
    if (!parcel) {
        return res.status(400).send({status: 'failed'})
    }
    res.status(200).send({status: 'recieved'})
})

app.listen(port, () => console.log(`server has start on port: ${port}`));